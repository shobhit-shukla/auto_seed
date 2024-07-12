# spec/spec_helper.rb
require 'bundler/setup'
require 'rspec'
require 'active_record'
require 'auto_seed'

# Set up an in-memory SQLite database for testing
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

# Load your schema or models here if necessary
# Example: require_relative '../app/models/your_model'

RSpec.configure do |config|
  config.before(:suite) do
    # Create your test schema or run migrations if needed
    ActiveRecord::Schema.define do
      create_table :your_models do |t|
        t.string :name
        t.timestamps
      end
    end
  end

  config.after(:each) do
    # Clean up the database after each test
    ActiveRecord::Base.connection.execute("DELETE FROM your_models")
  end
end
