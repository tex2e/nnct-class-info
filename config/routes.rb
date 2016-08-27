Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources 'cancel_info', only: [:show], constraints: { :id => /\d/ }
end
