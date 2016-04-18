class User < ActiveRecord::Base
  include Hertz::Notifiable

  def hertz_email
    email
  end
end
