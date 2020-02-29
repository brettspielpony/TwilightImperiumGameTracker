Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "welcome#show"

  resources :games, only: %i(show new create update), param: :uid do
    member do
      post :close
      post :start_next_round
      post :restart_current_round
    end

    resources :players, only: %i(show new create update destroy) do
      resources :technologies, only: %i(create destroy), param: :key
      resources :objectives, only: [], param: :key do
        post :score
      end
    end

    resources :rounds, only: %i(create) do
      member do
        post :pick_strategy_cards
        post :finish_action_phase
        post :finish_status_phase
        post :finish_agenda_phase
      end
    end
  end

  resources :technologies, only: %i(show), param: :key
end
