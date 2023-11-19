Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      namespace :auth, format: "json" do
        resources :sessions, format: "json", only: %i[index]
      end

      resources :tasks, format: "json" do
        resources :comments, format: "json"
        resources :taggings, format: "json", only: [:index, :create, :destroy]
      end

      resources :tags, format: "json" do
        collection do
          get 'search', to: 'tags#search'
        end
      end

      resources :diaries, format: "json" do
        member do
          get :edit
        end
        resources :diaries_image_relations, format: "json", only: [:create, :destroy]
        resources :diary_comments, format: "json"
        collection do
          get 'timeline', to: 'diaries#timeline'
        end
      end

      resources :images, format: "json", only: [:index, :show, :create, :destroy]

      resources :information_contents, format: "json", only: [:index]
    end
  end
end
