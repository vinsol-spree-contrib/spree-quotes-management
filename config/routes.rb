Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :quotes, except: [:show] do
      member do
        get :publish
        get :unpublish
      end
    end
  end

  resources :quotes, except: [:show, :destroy, :edit, :update]
end
