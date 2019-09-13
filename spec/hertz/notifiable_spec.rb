# frozen_string_literal: true

RSpec.describe Hertz::Notifiable do
  let(:user) { create(:user) }

  describe '.notifications' do
    let!(:notification) { create(:notification, receiver: user) }

    it "returns the receiver's notifications" do
      expect(user.notifications).to eq([notification])
    end
  end

  describe '#notify' do
    before do
      stub_const('TestNotification', Class.new(Hertz::Notification))
    end

    context 'with a notification object' do
      subject { -> { user.notify(TestNotification.new) } }

      it 'notifies the receiver' do
        expect(subject).to change(user.notifications, :count).by(1)
      end
    end

    context 'with a notification class' do
      subject { -> { user.notify(TestNotification, foo: 'bar') } }

      it 'notifies the receiver' do
        expect(subject).to change(user.notifications, :count).by(1)
      end

      it 'sets the provided meta' do
        subject.call
        expect(user.notifications.last.meta).to eq('foo' => 'bar')
      end
    end
  end
end
