Rails.application.routes.draw do
  resources :transactions
  
  root 'transactions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
