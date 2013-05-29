TextToSong::Application.routes.draw do

  root to: "songs#new"

  # get "http://rhymebrain.com/talk?function=getRhymes&word=:word" => "songs#new"
end
