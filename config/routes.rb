IbeaconWebappDemo::Application.routes.draw do

  root 'customers#index'
  resources :product_areas
  resources :events

  resources :customers do
    resources :visits
		post 'visits/new' => 'visits#create'
  end

  post 'visits/create' => 'visits#create'
  patch 'visits/update' => 'visits#update'

end
