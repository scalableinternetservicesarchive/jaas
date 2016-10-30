Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#landing'
  get 'static_pages/make_match'
  get 'static_pages/match_found'
  get 'static_pages/match_not_found'
end
