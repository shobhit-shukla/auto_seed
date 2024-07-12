require_relative "auto_seed/version"
require_relative "auto_seed/seeder"


# lib/auto_seed.rb
module AutoSeed
  class Error < StandardError; end

  if defined?(Rake)
    Dir[File.join(__dir__, 'tasks', '**', '*.rake')].each { |f| load f }
  end
end
