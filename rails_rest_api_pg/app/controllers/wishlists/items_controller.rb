class Wishlists::ItemsController < ApplicationController
  before_action :authenticate_and_set_user
  before_action :find_wishlist!, only: %i[index create]
  before_action :find_item!, only: %i[show update destroy]

  def index
    if items_collection.present?
      render json: { items: serialize(items_collection) }, status: :ok
    else
      render json: { messages: "Items can't be found" }, status: :unprocessable_entity
    end
  end

  def show
    if current_item.present?
      render json: { item: serialize(current_item) }, status: :ok
    else
      render json: { messages: "Item can't be found" }, status: :unprocessable_entity
    end
  end

  def create
    item = current_user.items.build(item_params)
    item.wishlist_id = wishlist_id

    if item.save
      render json: { item: item }, status: :ok
    else
      render json: { messages: "Item can't be created", errors: item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if current_item.update(item_params)
      render json: { item: current_item }, status: :ok
    else
      render json: { messages: "Item can't be updated", errors: current_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if current_item.destroy
      render json: { item: current_item }, status: :ok
    else
      render json: { messages: "Item can't be deleted", errors: current_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :link, :description, :status, :reserved_by, :gifted_by,
                                 :reserved_on, :gifted_on)
  end

  def find_wishlist!
    render json: { messages: "Wishlist can't be found" }, status: :unprocessable_entity unless wishlist_id
  end

  def find_item!
    render json: { messages: "Item can't be found" }, status: :unprocessable_entity unless current_item
  end

  def current_item
    @current_item ||= Item.where(user_id: current_user.id, wishlist_id: wishlist_id).first
  end

  def wishlist_id
    @wishlist_id ||= params[:wishlist_id]
  end

  def items_collection
    Item.where(user_id: current_user.id, wishlist_id: wishlist_id)
  end

  def serialize(resources)
    ItemSerializer.new(resources).serializable_hash
  end
end
