# spec/lib/auto_seed/seeder_spec.rb
require 'spec_helper'

RSpec.describe AutoSeed::Seeder do
  describe '.generate_seed_file' do
    it 'generates a seed file' do
      # Create a test model class
      class TestModel < ActiveRecord::Base
        self.table_name = 'test_models'
      end

      # Insert test data
      TestModel.create(name: 'Test Name', value: 42)

      # Call the method
      AutoSeed::Seeder.generate_seed_file

      # Check the seed file content
      seed_file_path = File.join(File.dirname(__FILE__), '..', '..', '..', 'db', 'seeds.rb')
      expect(File).to exist(seed_file_path)
      expect(File.read(seed_file_path)).to include('TestModel.create!')
    end
  end

  describe '.generate_sample_record' do
    it 'generates a sample record with appropriate data' do
      # Create a test model class
      class TestModel < ActiveRecord::Base
        self.table_name = 'test_models'
      end

      columns = [
        { name: 'name', type: :string },
        { name: 'value', type: :integer },
        { name: 'created_at', type: :datetime },
        { name: 'updated_at', type: :datetime }
      ]

      associations = []

      sample_record = AutoSeed::Seeder.generate_sample_record(TestModel, columns, associations)

      expect(sample_record).to include('name', 'value', 'created_at', 'updated_at')
      expect(sample_record['name']).to be_a(String)
      expect(sample_record['value']).to be_an(Integer)
    end
  end
end
