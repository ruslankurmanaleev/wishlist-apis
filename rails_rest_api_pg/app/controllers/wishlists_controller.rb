class WishlistsController < ApplicationController
  before_action :authenticate_and_set_user
  before_action :find_wishlist!, only: %i[show update destroy]

  def index
    render json: { wishlists: serialize(current_user.wishlists) }, status: :ok
  end

  def show
    if current_wishlist
      render json: { wishlist: current_wishlist }, status: :ok
    else
      render json: { messages: "Wishlist can't be created", errors: wishlist.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def create
    wishlist = current_user.wishlists.build(wishlist_params)

    if wishlist.save
      render json: { wishlist: wishlist }, status: :ok
    else
      render json: { messages: "Wishlist can't be created", errors: wishlist.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if current_wishlist.update(wishlist_params)
      render json: { wishlist: current_wishlist }, status: :ok
    else
      render json: { messages: "Wishlist can't be created", errors: current_wishlist.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if current_wishlist.destroy
      render json: { wishlist: current_wishlist }, status: :ok
    else
      render json: { messages: "Wishlist can't be deleted", errors: current_wishlist.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_wishlist!
    render json: { messages: "Wishlist can't be found" }, status: :unprocessable_entity unless current_wishlist
  end

  def current_wishlist
    @current_wishlist ||= Wishlist.find_by(user_id: current_user.id, id: params[:id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:title, :publicity_level, :status)
  end

  def serialize(resources)
    WishlistSerializer.new(resources).serializable_hash
  end
end
