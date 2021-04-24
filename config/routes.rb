Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    namespace :api do
      namespace :v1 do
        get '/auth', to: 'auth#create'
        get '/callback', to: 'users#create'
        resources :users, only: [:index]
        resources :playlists, only: %i[index create update destroy] do
          resources :playlist_items, only: %i[create]
        end
        resources :playlist_items, only: %i[destroy update]
      end
    end
  end
