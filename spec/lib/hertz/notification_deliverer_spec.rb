# frozen_string_literal: true
module Hertz
  RSpec.describe NotificationDeliverer do
    subject { described_class }

    before(:each) do
      module Courier
        class Test < Base
          def self.deliver_notification(_notification)
          end
        end
      end

      class TestNotification < Notification
        deliver_by :test
      end
    end

    describe '#deliver' do
      let(:notification) { TestNotification.new }

      it 'delivers the notification through the couriers' do
        expect(Hertz::Courier::Test).to receive(:deliver_notification)
          .with(notification)
          .once

        subject.deliver(notification)
      end
    end
  end
end
