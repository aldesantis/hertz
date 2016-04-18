# frozen_string_literal: true
module Hertz
  RSpec.describe NotificationMailer do
    describe '.notification_email' do
      let(:notification) { build_stubbed(:test_notification) }
      subject { described_class.notification_email(notification) }

      it 'sends the email to the receiver' do
        expect(subject.to).to eq([notification.receiver.email])
      end
    end
  end
end
