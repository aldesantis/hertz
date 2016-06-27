# frozen_string_literal: true
FactoryGirl.define do
  factory :delivery, class: 'Hertz::Delivery' do
    association :notification, strategy: :build
    courier 'test'
  end
end
