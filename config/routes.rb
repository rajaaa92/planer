Planer::Application.routes.draw do
  devise_for :users
  resources :projects, except: [:show]
  resources :missions, except: [:show]
  resources :ideas, except: [:show]
  resources :users, except: [:edit]

  authenticated :user do
    root 'users#show', as: "dashboard"
  end

  root 'projects#index'
end
