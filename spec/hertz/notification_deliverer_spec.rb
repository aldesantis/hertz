# frozen_string_literal: true
module Hertz
  RSpec.describe NotificationDeliverer do
    subject { described_class }

    before(:all) do
      module Courier
        class Test
          def self.deliver_notification(_notification)
          end
        end
      end
    end

    describe '#deliver' do
      let(:notification) do
        Class.new(TestNotification) do
          deliver_by :test
        end.new
      end

      it 'delivers the notification through the couriers' do
        expect(Hertz::Courier::Test).to receive(:deliver_notification)
          .once
          .with(notification)

        subject.deliver(notification)
      end

      context 'when common couriers are defined' do
        before(:all) do
          module Courier
            class Common
              def self.deliver_notification(_notification)
              end
            end
          end
        end

        before(:each) do
          allow(Hertz).to receive(:common_couriers)
            .and_return([:common])

          allow(Hertz::Courier::Test).to receive(:deliver_notification)
          allow(Hertz::Courier::Common).to receive(:deliver_notification)
        end

        it 'uses common couriers' do
          expect(Hertz::Courier::Test).to receive(:deliver_notification)
            .once
            .with(notification)

          subject.deliver(notification)
        end

        it 'uses model-specific couriers' do
          expect(Hertz::Courier::Common).to receive(:deliver_notification)
            .once
            .with(notification)

          subject.deliver(notification)
        end
      end
    end
  end
end
