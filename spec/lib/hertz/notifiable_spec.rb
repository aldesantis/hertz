module Hertz
  RSpec.describe Notifiable do
    let(:user) { create(:user) }

    describe '.notifications' do
      let!(:notification) { create(:notification, receiver: user) }

      it "returns the receiver's notifications" do
        expect(user.notifications).to eq([notification])
      end
    end

    describe '#notify' do
      it 'notifies the receiver' do
        expect {
          user.notify(Hertz::Notification.new(type: 'Hertz::Notification'))
        }.to change(user.notifications, :count).by(1)
      end
    end
  end
end
