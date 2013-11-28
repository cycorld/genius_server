GServer::Application.routes.draw do
  root 'web#index'
	match 'mobile' => "mobile#index", via: [:post]
	match 'mobile/:id' => "mobile#index", via: [:get, :post]
	match 'web/push' => "web#push", via: [:post]
  match 'push_message' => "web#push", via: [:get, :post]
  match 'receive_message' => "web#receive_message", via: [:get, :post]
  match 'get_users' => "web#get_users", via: [:get, :post]
  match 'flush' => "web#flush", via: [:get, :post]
end
