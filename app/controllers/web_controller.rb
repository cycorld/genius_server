class WebController < ApplicationController
  before_filter :is_admin, :except => [:login, :login_process]
  def index
    @msgs = Msg.where('send_id = ? OR recv_id = ?', params[:target_user_id], params[:target_user_id]).where(:deleted => false).order("created_at DESC")
		@users = User.all
  end

  def flush #Ajax call
    send_msgs = Msg.where(:send_id => params[:target_user_id])
    send_msgs << Msg.where(:recv_id => params[:target_user_id])
    send_msgs.each do |x|
      x.deleted = true
      x.save
    end
    render :json => {"result" => true}
  end

  def push #Ajax call
    msg = Msg.new
    msg.send_id = 1 #HARD CODED admin ID
    msg.recv_id = params[:target_user_id]
    msg.content = params[:content]
    msg.save
    #sender #receiver
    ['1', "#{params[:target_user_id]}"].each do |x|
      Pusher[x].trigger('new_msg', {
        content: params[:content],
        send_id: 1,
        recv_id: params[:target_user_id],
				time: msg.created_at
      })
    end

    render :json => {"result" => true}
  end

  def login
  end

  def login_process
    if (params[:user_name] == 'admin') and (params[:user_password] == 'tjdbrlfhdhtpdy')
      session[:admin] = true
      redirect_to :action => "index"
    else
      redirect_to :action => "login"
    end
  end

  def logout
    reset_session
    redirect_to :action => "login"
  end
end
