Rails.application.routes.draw do

 
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

    devise_scope :user do
      post 'users/verify_otp', to: 'devise/sessions#verify_otp'
    end
  
    namespace :api do
      namespace :v1 do
        resources :doctors, only: [:new, :create]
        resources :patients
        resources :lab_staffs
        resources :riders
        resources :labs
        resources :orders do
           resources :tests
        end
      end
    end
  
end
