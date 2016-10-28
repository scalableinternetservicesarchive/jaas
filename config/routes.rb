Rails.application.routes.draw do
  root 'static_pages#landing'
  get '/login', to: 'static_pages#login'
end
