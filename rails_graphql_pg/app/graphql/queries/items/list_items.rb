class Queries::Items::ListItems < Queries::BaseQuery
  description "List User's Items"

  type [Types::ItemType], null: true

  def resolve
    fetch_items
  end

  private

  def fetch_items
    context[:current_user].items
  end
end
