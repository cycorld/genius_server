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
		puts "params#{params.inspect}"
    msg = Msg.new
    msg.send_id = params[:send_user_id] #HARD CODED admin ID
    msg.recv_id = params[:target_user_id]
    msg.content = params[:content]
    msg.save
    #sender #receiver
    [params[:send_user_id], "#{params[:target_user_id]}"].each do |x|
      Pusher[x].trigger('new_msg', {
        content: params[:content],
        send_id: params[:send_user_id],
        recv_id: params[:target_user_id],
				time: msg.created_at.strftime("%p %l:%M")
      })
    end

    render :json => {"result" => true}
  end

	def receive_message
		msgs = Msg.where("(send_id = ? AND recv_id = ?) OR (send_id = ? AND recv_id = ?)", params[:my_user_id], params[:target_user_id], params[:target_user_id], params[:my_user_id])
		puts msgs.inspect
		user_msgs = Array.new
		msgs.each do |msg|
			user_msgs.push({
				content: msg.content,
				send_id: msg.send_id,
				recv_id: msg.recv_id,
				time: msg.created_at.strftime("%p %l:%M")
			});
		end

    render :json => user_msgs
	end

	def get_users
    render :json => User.all.to_json
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
