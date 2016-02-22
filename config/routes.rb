Rails.application.routes.draw do
  root to: "home#index"
  post :track, to: "home#track"

  get :advanced, to: "home#advanced"
  post :advanced_track, to: "home#advanced_track"
end
