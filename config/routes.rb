Rails.application.routes.draw do
  resources :records, only: [:index, :create, :destroy, :update, :last] 

  get '/last', to: 'records#last' # route to fetch last added student entry 

  root 'students#index' # default page 
end
