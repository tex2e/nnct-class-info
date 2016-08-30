Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/cancel_info/:id'               => 'cancel_info#show',               constraints: { :id => /\d/ }
  get '/cancel_info/:id/only_tomorrow' => 'cancel_info#show_only_tomorrow', constraints: { :id => /\d/ }
end
