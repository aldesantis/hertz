# frozen_string_literal: true
module Hertz
  RSpec.describe NotificationDeliverer do
    subject { described_class }

    let(:test_courier) do
      Class.new do
        def deliver_notification(notification)
        end
      end.new
    end

    before(:each) do
      allow(Hertz).to receive(:build_courier)
        .with(:test)
        .and_return(test_courier)
    end

    describe '#deliver' do
      let(:notification) do
        Class.new(TestNotification) do
          deliver_by :test
        end.new
      end

      it 'delivers the notification through the couriers' do
        expect(test_courier).to receive(:deliver_notification)
          .once
          .with(notification)

        subject.deliver(notification)
      end
    end
  end
end
