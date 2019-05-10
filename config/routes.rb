Rails.application.routes.draw do

  namespace :admins_backoffice do
    get 'welcome/index' #dashboard
    resources :admins, except: [:delete] #administradores
  end
  devise_for :users
  devise_for :admins

  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end

  get 'welcome/index'
  get 'inicio', to: 'site/welcome#index'
  
  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
