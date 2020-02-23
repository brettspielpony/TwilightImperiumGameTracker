Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "welcome#show"

  resources :games, only: %i(show new create update), param: :uid do
    member do
      post :close
    end

    resources :players, only: %i(show new create update) do
      resources :technologies, only: %i(create destroy), param: :key
    end
    resources :rounds, only: %i(create)
  end

  resources :technologies, only: %i(show), param: :key
end
