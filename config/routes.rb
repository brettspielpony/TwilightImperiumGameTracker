Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "welcome#show"

  resources :games, only: %i(show new create update), param: :uid do
    resources :players, only: %i(show new create update)
    resources :rounds, only: %i(create)
  end

  resources :players, only: [], param: :uid do
    resources :technologies, only: %i(create destroy)
  end
end
