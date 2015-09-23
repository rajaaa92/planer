Planer::Application.routes.draw do

  devise_for :users, controllers: { registrations: "devise_custom/registrations" }

  resources :projects, except: [:show] do
    collection { post :sort }
  end
  resources :missions, except: [:show]
  resources :ideas, except: [:show]
  resources :problems, except: [:show]
  resources :users, except: [:edit]

  authenticated :user do
    root 'welcome#index', as: "dashboard"
  end

  root 'welcome#index'
end
