GServer::Application.routes.draw do
  root 'web#index'
  match 'mobile' => "mobile#index", via: [:get, :post]
end
