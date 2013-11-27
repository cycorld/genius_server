class MobileController < ApplicationController
  def index

  end

  def push
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end
end
