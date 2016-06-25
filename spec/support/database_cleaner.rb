require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation,
      except: %w[spatial_ref_sys schema_migrations]
    )
  end

  config.before(:each) { DatabaseCleaner.strategy = :truncation }

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation,
      { except: %w[spatial_ref_sys schema_migrations] }
  end

  config.before(:each) { DatabaseCleaner.start }
  config.append_after(:each) { DatabaseCleaner.clean }
end
