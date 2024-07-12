namespace :db do
  desc "Generate seed file from schema comments"
  task generate_seeds: :environment do
    AutoSeed::Seeder.generate_seed_file
  end
end
