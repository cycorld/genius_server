class WebController < ApplicationController
  def index

  end

  def push

  end

  def login

  end

  def logout
    reset_session
    redirect_to :action => "login"
  end
end
