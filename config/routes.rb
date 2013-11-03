QuizRunner::Application.routes.draw do
  scope format: false do
    num_ptn = /\d+/

    root to: 'home#show'

    resources :quizzes

    resources :plays, only: %w(index create show) do
      member do
        post :players, action: 'create_player'
        get  :result
        get  :result_chart
        get  "/play(/:step)", action: 'play', as: :play, step: num_ptn
        post "/play(/:step)", action: 'do_play', step: num_ptn
      end
    end

    resources :players, only: %w(show) do
      member do
        get  "/play/:step", action: 'play', as: :play, step: num_ptn
        post "/play/:step", action: 'do_play', step: num_ptn
      end
    end
  end
end
