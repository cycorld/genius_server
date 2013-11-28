class MobileController < ApplicationController
  def index
		@my_user_id = params[:id] || '0' 
  end

  def push
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end
end
