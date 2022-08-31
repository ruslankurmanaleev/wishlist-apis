class Mutations::Items::DeleteItem < Mutations::BaseMutation
  description "Removes Item for the user"

  argument :id, ID, required: true, description: "Provide ID of Item"

  field :errors, [String], null: false, description: "Indicates Errors"
  field :item, Types::ItemType, null: false, description: "Returns Item"
  field :success, Boolean, null: false, description: "Indicates Success"

  def authorized?(**_inputs)
    context[:current_user].present?
  end

  def resolve(id: nil)
    item = fetch_item(id)

    if item.destroy
      { success: true, item: item, errors: [] }
    else
      { success: false, item: item, errors: [removing_error_message] }
    end
  end

  private

  def fetch_item(id)
    Item.find_by(id: id, user_id: context[:current_user])
  end

  def removing_error_message
    "Can't remove the Item"
  end
end
