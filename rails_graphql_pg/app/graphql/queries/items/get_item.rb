class Queries::Items::GetItem < Queries::BaseQuery
  description "Get Item"

  argument :id, ID, required: true, description: "Provide ID of Item"

  type Types::ItemType, null: true

  def resolve(input)
    fetch_item(input[:id])
  end

  private

  def fetch_item(item_id)
    Item.find_by(id: item_id, user_id: context[:current_user])
  end
end
