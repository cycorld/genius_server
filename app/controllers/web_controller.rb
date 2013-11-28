class WebController < ApplicationController
  def index
		@users = User.all
  end

  def flush
    send_msgs = Msg.where(:send_id => params[:target_user_id])
    send_msgs << Msg.where(:recv_id => params[:target_user_id])

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
