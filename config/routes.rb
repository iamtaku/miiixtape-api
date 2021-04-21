Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    namespace :api do
      namespace :v1 do
        get '/auth', to: 'auth#create'
        get '/callback', to: 'users#create'
        resources :users, only: [:show]
        resources :playlists, only: %i[index create update destroy] do
          resources :playlist_items, only: %i[create update]
        end
        resources :playlist_items, only: [:destroy]
      end
    end
  end
