Rails.application.routes.draw do
  root 'trips#index'

  post 'trips' => 'trips#create'
end
