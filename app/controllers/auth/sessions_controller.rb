class Auth::SessionsController < ::DeviseTokenAuth::SessionsController
  before_action :authenticate_user!, except: %i[new create validate_token]

  wrap_parameters format: []
end
