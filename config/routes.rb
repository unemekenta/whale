Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      namespace :auth do
        resources :sessions, only: %i[index]
      end

      resources :tasks do
        resources :comments
        resources :taggings, only: [:index, :create, :destroy]
      end

      resources :tags do
        collection do
          get 'search', to: 'tags#search'
        end
      end

      resources :diaries do
        collection do
          get 'timeline', to: 'diaries#timeline'
        end
      end
    end
  end
end
