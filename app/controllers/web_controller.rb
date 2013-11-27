class WebController < ApplicationController
  def index

  end

  def flush

  end

  def push #Ajax call

  end

  def login
    if !session[:user_id].nil?
      redirect_to :action => "index"
    end
  end

  def login_process
    session[:user_id] = params[:user_id]
    redirect_to :action => "index"
  end

  def logout
    reset_session
    redirect_to :action => "login"
  end
end
