# frozen_string_literal: true
RSpec.describe Hertz do
  describe '.configure' do
    it 'configures the module'
  end

  describe '.validate_couriers' do
    context 'when all couriers exists' do
      it 'does not raise any errors'
    end

    context 'when at least one courier does not exist' do
      it 'raises an InvalidCourierError'
    end
  end

  describe '.validate_courier' do
    context 'when the courier exists' do
      it 'does not raise an error'
    end

    context 'when the courier does not exist' do
      it 'raises an InvalidCourierError'
    end
  end

  describe '.build_courier' do
    it 'returns an instance of the given courier'
  end
end
