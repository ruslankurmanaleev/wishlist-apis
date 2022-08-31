class Mutations::Items::CreateItem < Mutations::BaseMutation
  description "Creates Item for the user"

  argument :input, Inputs::ItemInput, required: true, description: "Provide attributes of Item"

  field :errors, [String], null: false, description: "Indicates Errors"
  field :item, Types::ItemType, null: false, description: "Returns Item"
  field :success, Boolean, null: false, description: "Indicates Success"

  def authorized?(**_inputs)
    context[:current_user].present?
  end

  def resolve(input: nil)
    item = context[:current_user].items.build(input.to_h)

    if item.save
      { success: true, item: item, errors: [] }
    else
      { success: false, item: item, errors: item.errors.full_messages }
    end
  end
end
