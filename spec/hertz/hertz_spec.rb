# frozen_string_literal: true
RSpec.describe Hertz do
  describe '.configure' do
    it 'configures the module' do
      expect {
        Hertz.configure do |config|
          config.common_couriers = [:test]
        end
      }.to change(Hertz, :common_couriers).to([:test])
    end
  end
end
