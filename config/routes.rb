LoveRequest::Application.routes.draw do
  match 'travis/callback' => 'travis#callback'
end


