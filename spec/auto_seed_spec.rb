# spec/tasks/auto_seed_spec.rb
require 'rake'
require 'auto_seed'

RSpec.describe 'AutoSeed Rake Tasks' do
  before :all do
    Rake.application.load_rakefile
    Rake::Task.clear
    Rake.application.load_tasks
  end

  describe 'db:generate_seeds' do
    it 'is defined' do
      expect(Rake::Task.task_defined?('db:generate_seeds')).to be true
    end

    it 'creates db/seeds.rb' do
      Rake::Task['db:generate_seeds'].invoke
      expect(File).to exist('db/seeds.rb')
    end

    after do
      File.delete('db/seeds.rb') if File.exist?('db/seeds.rb')
    end
  end
end
