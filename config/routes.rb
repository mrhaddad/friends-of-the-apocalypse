Fota::Application.routes.draw do
  resources :statuses, only: [:new, :create]
  root :to => 'welcome#index'
end
