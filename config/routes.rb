GServer::Application.routes.draw do
  root 'web#index'

  resources :webs do 
    member do 
      get 'index'
    end
  end


end
