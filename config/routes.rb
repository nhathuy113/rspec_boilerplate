Rails.application.routes.draw do
  # Helper to split routes into separate files under config/routes/
  def draw(route_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{route_name}.rb")))
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Auth-related routes
  draw :auth
  
  # Root route
  root 'pages#login'
  
  # API routes
  post '/register_phone', to: 'smartphones#create'
end
