# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :shelters
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

  # resources :pets, only: [:index, :show]
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'

  get '/shelters/:id/pets/:id', to: 'pets#show'
  get '/shelters/:id/pets/:id/edit', to: 'pets#edit'
  patch '/shelters/:shelter_id/pets/:pet_id', to: 'pets#update'
  delete '/shelters/:shelter_id/pets/:pet_id', to: 'pets#destroy'
  
  patch '/favorites/:pet_id', to: 'favorites#update'
  # patch '/favorite/:id', to: 'favorite#update'
  get '/favorites', to: 'favorites#index'
  delete 'favorites/:pet_id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy_all'
  
  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  get '/applications/:id', to: 'applications#show'
  get '/pets/:pet_id/applications', to: 'application_pets#index'
  patch '/pets/:pet_id/:app_id', to: 'application_pets#update'
  patch '/pets', to:'application_pets#batch_update'
  # patch '/applications/:id', to: 'applications#update'

end
