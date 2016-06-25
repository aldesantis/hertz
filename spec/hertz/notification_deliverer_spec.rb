# frozen_string_literal: true
module Hertz
  RSpec.describe NotificationDeliverer do
    subject { described_class }

    before(:each) do
      class TestNotification < Notification
        deliver_by :test
      end
    end

    describe '#deliver' do
      let(:notification) { TestNotification.new }

      it 'delivers the notification through the couriers'
    end
  end
end
