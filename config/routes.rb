GServer::Application.routes.draw do
  root 'web#index'
  match 'mobile' => "mobile#index", via: [:get, :post]
  match 'push_message' => "web#push", via: [:get, :post]
  match 'receive_message' => "web#receive_message", via: [:get, :post]
end
