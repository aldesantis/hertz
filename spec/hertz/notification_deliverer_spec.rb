# frozen_string_literal: true
module Hertz
  RSpec.describe NotificationDeliverer do
    subject { described_class }

    let(:test_courier) do
      Class.new do
        def self.deliver_notification(_notification)
        end
      end
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

      context 'when common couriers are defined' do
        let(:common_courier) do
          Class.new do
            def self.deliver_notification(_notification)
            end
          end
        end

        before(:each) do
          allow(Hertz).to receive(:common_couriers)
            .and_return([:common])

          allow(Hertz).to receive(:build_courier)
            .with(:common)
            .and_return(common_courier)

          allow(test_courier).to receive(:deliver_notification)
          allow(common_courier).to receive(:deliver_notification)
        end

        it 'uses common couriers' do
          expect(test_courier).to receive(:deliver_notification)
            .once
            .with(notification)

          subject.deliver(notification)
        end

        it 'uses model-specific couriers' do
          expect(common_courier).to receive(:deliver_notification)
            .once
            .with(notification)

          subject.deliver(notification)
        end
      end
    end
  end
end
