Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :quotes, except: [:show]
  end

  resources :quotes, except: [:show, :destroy, :edit, :update]
end
