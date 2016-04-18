# Hertz

[![Dependency Status](https://gemnasium.com/badges/github.com/alessandro1997/hertz.svg)](https://gemnasium.com/github.com/alessandro1997/hertz)
[![Code Climate](https://codeclimate.com/github/alessandro1997/hertz/badges/gpa.svg)](https://codeclimate.com/github/alessandro1997/hertz)

Hertz is a Ruby on Rails engine for sending in-app notification to your users.

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

Then, install and run the migrations:

```console
$ rake hertz:install:migrations db:migrate
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

### Notifying users

You can use `#notify` for notifying a user:

```ruby
notification = CommentNotification.new
user.notify(notification)
```

You can attach custom meta to a notification, but make sure it can be cleanly
stored in an hstore:

```ruby
notification = CommentNotification.new(meta: { comment_id: comment.id })
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

## Built-in couriers

### Email

The email courier delivers your notifications by email. In order to use this
courier, add `:email` to `deliver_by` in the notification model(s):

```ruby
class CommentNotification < Hertz::Notification
  deliver_by :email
end
```

You will also need to expose the `hertz_email` method on your receiver class:

```ruby
class User < ActiveRecord::Base
  def hertz_email
    email
  end
end
```

Finally, you should create a template for every notification you send by email.
For `CommentNotification` you'd create a template at
`app/views/hertz/notification_mailer/comment_email.html.erb`:

```erb
<p>Hey <%= @notification.receiver.email %>,</p>
<p>you've got a new comment!</p>
```

As you can see, templates have access to the `@notification` instance variable.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/alessandro1997/hertz.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
