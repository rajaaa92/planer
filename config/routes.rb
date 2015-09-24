Planer::Application.routes.draw do

  devise_for :users, controllers: { registrations: "devise_custom/registrations", sessions: "devise_custom/sessions" }

  resources :projects, except: [:show] do
  resources :missions, except: [:show, :edit, :new] do
    collection { post :sort }
  end
  resources :ideas, except: [:show, :edit, :new] do
    collection { post :sort }
  end
  resources :problems, except: [:show, :edit, :new] do
    collection { post :sort }
  end
  resources :users, except: [:edit]

  authenticated :user do
    root 'projects#index', as: "dashboard"
  end

  root 'welcome#index'
end
