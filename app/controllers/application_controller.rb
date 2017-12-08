class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['LOGIN_NAME'] && password == ENV['LOGIN_PASSWORD']
    end
  end

end
