Rails.application.routes.draw do
  api_guard_routes for: "users"

  resources :wishlists do
    resources :items, controller: "wishlists/items"
  end
end
