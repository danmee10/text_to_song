TextToSong::Application.routes.draw do

  root to: "songs#new"
  post "/editor/:text", "songs#edit"

  # get "http://rhymebrain.com/talk?function=getRhymes&word=:word" => "songs#new"
end
