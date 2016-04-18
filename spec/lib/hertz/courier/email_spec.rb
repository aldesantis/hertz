# frozen_string_literal: true
module Hertz
  module Courier
    RSpec.describe Email do
      subject { described_class }

      describe '.deliver_notification' do
        let(:notification) { instance_double('Hertz::Notification') }
        let(:email) { instance_spy('ActionMailer::MessageDelivery') }

        before(:each) do
          allow(Hertz::NotificationMailer).to receive(:notification_email)
            .with(notification)
            .and_return(email)
        end

        it 'sends an email' do
          subject.deliver_notification(notification)

          expect(email).to have_received(:deliver_later)
            .once
        end
      end
    end
  end
end
