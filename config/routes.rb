Rails.application.routes.draw do
  root to: "home#index"
  post :track, to: "home#track"
end
