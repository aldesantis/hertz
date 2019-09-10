class User < ApplicationRecord
  include Hertz::Notifiable

  def hertz_email
    email
  end
end
