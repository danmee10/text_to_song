TextToSong::Application.routes.draw do

  root to: "songs#new"

  resources :songs
  resources :lines

  namespace :api do
    resources :words, :defaults => { :format => 'json' }
    resources :lines, :defaults => { :format => 'json' }
  end
end
