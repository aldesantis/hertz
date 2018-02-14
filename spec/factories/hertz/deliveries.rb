# frozen_string_literal: true

FactoryBot.define do
  factory :delivery, class: 'Hertz::Delivery' do
    association :notification, strategy: :build
    courier 'test'
  end
end
