Rails.application.routes.draw do
  resources :teams
  root to: 'teams#index'

  post 'populate_all_website_data', to: 'application#populate_all_website_data'
  delete 'delete_all_website_data', to: 'application#delete_all_website_data'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
