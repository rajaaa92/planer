Planer::Application.routes.draw do

  devise_for :users, controllers: {
      registrations: "devise_custom/registrations",
      sessions: "devise_custom/sessions",
      passwords: "devise_custom/passwords"
    }

  resources :projects, except: [:show, :edit, :new] do
    collection do
      post :sort
      post :import
    end
  end
  resources :missions, controller: :items, except: [:show, :edit, :new] do
    collection { post :sort }
  end
  resources :ideas, controller: :items, except: [:show, :edit, :new] do
    collection { post :sort }
  end
  resources :problems, controller: :items, except: [:show, :edit, :new] do
    collection { post :sort }
  end
  resources :users, except: [:edit]

  authenticated :user do
    root 'projects#index', as: "dashboard"
  end

  root 'welcome#index'
end
