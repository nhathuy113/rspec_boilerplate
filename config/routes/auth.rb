# Authentication routes
get '/login', to: 'pages#login'
get '/welcome', to: 'pages#welcome'

# OAuth routes
get '/auth/:provider/callback', to: 'sessions#create'
get '/auth/failure', to: 'sessions#failure'
delete '/sign_out', to: 'sessions#destroy', as: :sign_out
delete '/signout',  to: 'sessions#destroy'
get    '/sign_out', to: 'sessions#destroy'   # Fallback when JS method override is unavailable
get    '/signout',  to: 'sessions#destroy'

# Legal pages
get '/legal', to: 'pages#legal'




