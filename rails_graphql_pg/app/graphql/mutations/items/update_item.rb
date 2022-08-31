class Mutations::Items::UpdateItem < Mutations::BaseMutation
  description "Updates Item for the user"

  argument :input, Inputs::ItemInput, required: true, description: "Provide attributes of Item"

  field :errors, [String], null: false, description: "Indicates Errors"
  field :item, Types::ItemType, null: false, description: "Returns Item"
  field :success, Boolean, null: false, description: "Indicates Success"

  def authorized?(**_inputs)
    context[:current_user].present?
  end

  def resolve(input: nil)
    item = fetch_item(input.id)

    return { success: false, item: nil, errors: [not_found_error_message] } unless item

    if item.update(input.to_h.except(:id, :wishlist_id))
      { success: true, item: item, errors: [] }
    else
      { success: false, item: item, errors: item.errors.full_messages }
    end
  end

  private

  def fetch_item(id)
    Item.find_by(id: id, user_id: context[:current_user])
  end

  def not_found_error_message
    "Item couldn't be found"
  end
end
