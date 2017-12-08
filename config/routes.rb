Rails.application.routes.draw do
  apipie
  resources :records, only: [:index, :create, :destroy, :update, :last, :nested]
  get '/api/v1', to: redirect('/docs/v1/apidoc.html') 
  get '/api/v2', to: redirect('/docs/v2/apidoc.html')

  get '/last', to: 'records#last' # route to fetch last added student entry 
  # get '/nested', to: 'records#nested'

  root 'students#index' # default page 

  # resources :students do 
  # 	resources :records, only: [:index, :create, :destroy, :update, :last] 
  # end
end
