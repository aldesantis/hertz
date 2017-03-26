# frozen_string_literal: true

RSpec.describe Hertz do
  describe '.configure' do
    after { described_class.common_couriers = [] }

    it 'configures the module' do
      expect {
        described_class.configure do |config|
          config.common_couriers = [:test]
        end
      }.to change(described_class, :common_couriers).to([:test])
    end
  end
end
