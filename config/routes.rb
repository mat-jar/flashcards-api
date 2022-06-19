Rails.application.routes.draw do
  get 'messages/index'
  devise_for :users, path: 'api/v1/users', defaults: { format: :json },
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get 'api/v1/users/user_details', to: 'users/user_details#show'
  put 'api/v1/users/user_details', to: 'users/user_details#update'
  get 'api/v1/users/user_details_all', to: 'users/user_details#show_all'
  scope '/api/v1' do
    resources :articles
  end

  namespace :api do
      namespace :v1 do
        resources :learning_sessions do
          post 'show_specific', on: :collection
          # on: :collection  zamienia /api/v1/learning_sessions/:id/show_specific(.:format)  na /api/v1/learning_sessions/show_specific(.:format)
        end
      end
    end

    namespace :api do
        namespace :v1 do
          post 'answer_times', to: 'answer_times#create'
          namespace :answer_times do
            get 'user_average', to: 'user_average'
            get 'flashcard_set_average', to: 'flashcard_set_average'
            get 'word_average', to: 'word_average'
            get 'learning_session_average', to: 'learning_session_average'
          end
        end
      end

      namespace :api do
          namespace :v1 do
            namespace :message_storage do
              get 'list', to: 'list'
            end
          end
        end

  namespace :api do
      namespace :v1 do
        resources :flashcard_sets do
          resources :flashcards, shallow: true
        end
      end
  end

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end

end
