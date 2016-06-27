# frozen_string_literal: true
module Hertz
  RSpec.describe Delivery do
    subject { build_stubbed(:delivery) }

    %w(notification courier).each do |attribute|
      it "validates the presence of #{attribute}" do
        expect(subject).to validate_presence_of(attribute)
      end
    end
  end
end
