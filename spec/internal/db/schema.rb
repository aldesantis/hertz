# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table(:users, force: true) do |t|
    t.string :email
  end
end
