class User < ActiveRecord::Base
  include Hertz::Notifiable
end
