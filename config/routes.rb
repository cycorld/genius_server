GServer::Application.routes.draw do
  root 'web#index'
  match 'mobile' => "mobile#index", via: [:get, :post]
  match 'push_web' => "web#push", via: [:get, :post]
end
