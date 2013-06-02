TextToSong::Application.routes.draw do

  root to: "songs#new"

  resources :songs

  namespace :api do
    resources :words, :defaults => { :format => 'json' }
  end
  # post "/editor/:text" => "songs#edit"

  # get "http://rhymebrain.com/talk?function=getRhymes&word=:word" => "songs#new"
end
