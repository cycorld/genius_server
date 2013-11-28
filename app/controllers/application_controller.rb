class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def is_admin?
    if !session[:admin].nil?
      redirect_to :action => "login", :controller => 'web'
    end
  end
end
