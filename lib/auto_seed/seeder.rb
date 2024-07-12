module AutoSeed
  class Seeder
    def self.generate_seed_file
      File.open('db/seeds.rb', 'w') do |file|
        ActiveRecord::Base.descendants.each do |model|
          next if model.name.in?(%w[ApplicationRecord ActiveRecord::Base]) # Skip base classes

          file.puts "## #{model.name} seeds"

          begin
            attributes = model.columns.reject { |col| col.name.in?(%w[ip_address current_sign_in_at]) }
            file.puts "#{model.name}.create!("

            attributes.each do |attribute|
              file.puts "  #{attribute.name}: 'sample_value',"
            end

            model.reflect_on_all_associations.each do |assoc|
              case assoc.macro
              when :has_many
                file.puts "  #{assoc.name}: [#{assoc.klass}.create!(...)]"
              when :belongs_to
                file.puts "  #{assoc.name}: #{assoc.klass}.first"
              when :has_one
                file.puts "  #{assoc.name}: #{assoc.klass}.create!(...)"
              when :has_many_attached
                file.puts "  #{assoc.name}: [#{assoc.klass}.attach(...)]"
              end

              # Handle polymorphic associations
              if assoc.polymorphic?
                file.puts "  #{assoc.name}_type: '#{assoc.klass}',"
                file.puts "  #{assoc.name}_id: #{assoc.klass}.first.id"
              end
            end

            file.puts ");"
          rescue StandardError => e
            file.puts "# Error generating seed for #{model.name}: #{e.message}"
          end

          file.puts "\n"
        end
      end
    end
  end
end
