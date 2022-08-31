require "json_web_token"

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
      decoded_token: decoded_token
    }
    result = RailsGraphqlPgSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} },
           status: :internal_server_error
  end

  def current_user
    return @current_user = nil unless decoded_token

    user = User.find_by(id: decoded_token[:user_id]) if decoded_token[:user_id].present?

    @current_user ||= user if user.present?
  end

  def decoded_token
    header = request.headers["Authorization"]&.split(" ")&.last

    return nil unless header

    @decoded_token ||= JsonWebToken.decode(header)
  rescue => e
    raise GraphQL::ExecutionError, e.message
  end
end
