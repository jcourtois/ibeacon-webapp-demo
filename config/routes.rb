IbeaconWebappDemo::Application.routes.draw do

  root 'customers#index'
  resources :product_areas
  resources :events

  resources :customers do
    resources :visits do
      collection do
        get 'coupons_served_up'
        get 'pie_chart_data'
        get 'activity'
      end
    end
  end

  post 'visits/create' => 'visits#create'
  patch 'visits/update' => 'visits#update'

end
