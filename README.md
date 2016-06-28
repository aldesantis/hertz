# Hertz

[![Gem Version](https://badge.fury.io/rb/hertz.svg)](https://badge.fury.io/rb/hertz)
[![Dependency Status](https://gemnasium.com/badges/github.com/alessandro1997/hertz.svg)](https://gemnasium.com/github.com/alessandro1997/hertz)
[![Code Climate](https://codeclimate.com/github/alessandro1997/hertz/badges/gpa.svg)](https://codeclimate.com/github/alessandro1997/hertz)

Hertz is a Ruby on Rails engine for sending in-app notifications to your users.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hertz'
```

And then execute:

```console
$ bundle
```

Or install it yourself as:

```console
$ gem install hertz
```

Then, run the installer generator:

```console
$ rails g hertz:install
$ rake db:migrate
```

Finally, add the following to the model that will receive the notifications
(e.g. `User`):

```ruby
class User < ActiveRecord::Base
  include Hertz::Notifiable
end
```

## Usage

### Using couriers

Couriers are what Hertz uses to deliver notifications to your users. For
instance, you might have a courier for delivering notifications by SMS and
another one for delivering them by email.

Creating a new courier in Hertz is easy:

```ruby
module Hertz
  module Courier
    class Sms
      def self.deliver_notification(notification)
        # ...
      end
    end
  end
end
```

Again, you don't have to use couriers if you only display notifications on your
website using standard AR methods.

### Creating new notification types

In Hertz, every notification is a model. If you want to create a new
notification type, just create a new model inheriting from
`Hertz::Notification`:

```ruby
class CommentNotification < Hertz::Notification
end
```
Since not all notifications might implement interfaces for all couriers, you
have to manually specify which couriers they implement via `deliver_by`:

```ruby
class CommentNotification < Hertz::Notification
  deliver_by :sms, :email
end
```

Notifications are not required to implement any couriers.

You can set common couriers (i.e. couriers that will be used for all
notifications) by putting the following into an initializer:

```ruby
Hertz.configure do |config|
  config.common_couriers = [:sms, :email]
end
```

### Attaching metadata to a notification

You can attach custom metadata to a notification, but make sure it can be
cleanly stored in an hstore:

```ruby
notification = CommentNotification.new(meta: { comment_id: comment.id })
user.notify(notification)
```

You can then unserialize any data in the model:

```ruby
class CommentNotification < Hertz::Notification
  def comment
    Comment.find(meta['comment_id'])
  end
end
```

Note that you should always access your metadata with string keys, regardless of
the type you use when attaching it.

### Notifying users

You can use `#notify` for notifying a user:

```ruby
notification = CommentNotification.new
user.notify(notification)
```

You can access a user's notifications with `#notifications`:

```ruby
current_user.notifications
current_user.notifications.unread
```

You can also mark notifications as read/unread:

```ruby
notification.mark_as_read
notification.mark_as_unread
```

### Tracking delivery status

Hertz provides an API couriers can use to mark the notification as delivered.
This allows you to know which couriers have successfully delivered your
notifications and helps prevent double deliveries:

```ruby
notification.delivered_with?(:email) # => false
notification.mark_delivered_with(:email) # => Hertz::Delivery
notification.delivered_with?(:email) # => true
```

Hertz does not enforce usage of the delivery API in any way, so some couriers
might not take advantage of it.

## Available couriers

- [hertz-courier-twilio](https://github.com/alessandro1997/hertz-courier-twilio):
  delivers notifications by SMS with the Twilio API.
- [hertz-courier-email](https://github.com/alessandro1997/hertz-courier-email):
  delivers notifications by email with ActionMailer.
- [hertz-courier-intercom](https://github.com/alessandro1997/hertz-courier-intercom):
  delivers notifications as Intercom conversations.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/alessandro1997/hertz.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
