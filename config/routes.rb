Rails.application.routes.draw do
  default_url_options host: 'localhost'

  mount_devise_token_auth_for 'User', at: 'auth',
                                      controllers: {
                                        sessions: 'auth/sessions'
                                      }
  resources :users, only: %i[create update destroy]
end
