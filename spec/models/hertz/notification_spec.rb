module Hertz
  RSpec.describe Notification do
    subject { build(:notification) }

    describe '#read?' do
      it 'returns whether read_at is present' do
        expect {
          subject.read_at = Time.zone.now
        }.to change(subject, :read?).from(false).to(true)
      end
    end

    describe '#unread?' do
      it 'returns whether read_at is nil' do
        expect {
          subject.read_at = Time.zone.now
        }.to change(subject, :unread?).from(true).to(false)
      end
    end

    describe '#mark_as_read' do
      subject { create(:notification) }

      it 'touches read_at' do
        expect {
          subject.mark_as_read
        }.to change(subject, :read_at).to(
          an_instance_of(ActiveSupport::TimeWithZone)
        )
      end
    end

    describe '#mark_as_unread' do
      subject { create(:notification, :read) }

      it 'nullifies read_at' do
        expect {
          subject.mark_as_unread
        }.to change(subject, :read_at).to(nil)
      end
    end

    describe '.unread' do
      let!(:unread_notification) { create(:notification) }
      let!(:read_notification) { create(:notification, :read) }

      it 'returns the unread notifications' do
        expect(Notification.unread).to eq([unread_notification])
      end
    end

    it 'delivers itself upon creation' do
      expect(Hertz::NotificationDeliverer).to receive(:deliver)
        .with(subject)
        .once

      subject.save!
    end
  end
end
