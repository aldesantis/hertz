# frozen_string_literal: true

RSpec.describe Hertz::NotificationDeliverer do
  subject { described_class }

  before do
    stub_const('Hertz::Test', (Class.new do
      def self.deliver_notification(_notification); end
    end))
  end

  describe '#deliver' do
    let(:notification) do
      stub_const('TestNotification', (Class.new(Hertz::Notification) do
        deliver_by :test
      end)).new
    end

    it 'delivers the notification through the couriers' do
      expect(Hertz::Test).to receive(:deliver_notification)
        .once
        .with(notification)

      subject.deliver(notification)
    end

    context 'when common couriers are defined' do
      before do
        stub_const('Hertz::Common', (Class.new do
          def self.deliver_notification(_notification); end
        end))

        allow(Hertz).to receive(:common_couriers).and_return([:common])
        allow(Hertz::Test).to receive(:deliver_notification)
        allow(Hertz::Common).to receive(:deliver_notification)
      end

      it 'uses common couriers' do
        expect(Hertz::Test).to receive(:deliver_notification)
          .once
          .with(notification)

        subject.deliver(notification)
      end

      it 'uses model-specific couriers' do
        expect(Hertz::Common).to receive(:deliver_notification)
          .once
          .with(notification)

        subject.deliver(notification)
      end
    end
  end
end
