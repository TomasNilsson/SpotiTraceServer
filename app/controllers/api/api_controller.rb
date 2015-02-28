class Api::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token # This should go into every Rails API controller
  before_filter :restrict_access

  private
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(token: token).first
    end
  end

  protected
  def request_http_token_authentication(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: {error: "Invalid token"}, status: :unauthorized
  end
end
