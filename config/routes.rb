Rails.application.routes.draw do

  root to: "home#index"
  post :track, to: "home#track"
  delete "logout", to: "home#logout"

  get :advanced, to: "home#advanced"
  post :advanced_track, to: "home#advanced_track"

  get "account", to: "accounts#show"
  post "accounts/transfer", to: "accounts#transfer"


end
