class User < ActiveRecord::Base
  has_many  :msgs
end
