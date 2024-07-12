module AutoSeed
  class Seeder
    DEVISE_COLUMNS = %w[
      last_sign_in_at current_sign_in_at last_sign_in_ip current_sign_in_ip
      encrypted_password reset_password_token reset_password_sent_at
      remember_created_at sign_in_count
    ].freeze

    def self.generate_seed_file
      File.open('db/seeds.rb', 'w') do |file|
        ActiveRecord::Base.descendants.each do |model|
          next if skip_model?(model)

          file.puts "## #{model.name} seeds"

          begin
            attributes = fetch_attributes(model)
            attribute_values = generate_attributes(attributes)
            file.puts "#{model.name}.create!("
            attribute_values.each { |attr, value| file.puts "  #{attr}: #{value.inspect}," }

            associations = handle_associations(model)
            associations.each { |assoc| file.puts "  #{assoc[:name]}: #{assoc[:value]}," }

            file.puts ");"
          rescue StandardError => e
            file.puts "# Error generating seed for #{model.name}: #{e.message}"
          end

          file.puts "\n"
        end
      end
    end

    private

    def self.skip_model?(model)
      model.name.in?(%w[ApplicationRecord ActiveRecord::Base])
    end

    def self.fetch_attributes(model)
      model.columns.reject { |col| col.name.in?(DEVISE_COLUMNS + %w[ip_address current_sign_in_at]) }.map(&:name)
    end

    def self.generate_attributes(attributes)
      attributes.each_with_object({}) do |attribute, hash|
        hash[attribute] = generate_sample_value(attribute)
      end
    end

    def self.generate_sample_value(attribute)
      case attribute
      when /_at$/
        "'#{Time.now}'"
      when /_on$/
        "'#{Date.today}'"
      when /date$/
        "'#{Date.today}'"
      else
        "'sample_value'"
      end
    end

    def self.handle_associations(model)
      associations = []
      model.reflect_on_all_associations.each do |association|
        next if association.options[:optional]

        case association.macro
        when :has_many
          associations.concat(handle_has_many_association(association))
        when :belongs_to
          associations.concat(handle_belongs_to_association(association))
        when :has_one
          associations.concat(handle_has_one_association(association))
        when :has_many_attached
          associations.concat(handle_has_many_attached_association(association))
        end

        if association.polymorphic?
          associations.concat(handle_polymorphic_association(association))
        end
      end
      associations
    end

    def self.handle_has_many_association(association)
      [{ name: association.name, value: "[#{association.klass}.create!(...)]" }]
    end

    def self.handle_belongs_to_association(association)
      [{ name: association.name, value: "#{association.klass}.first" }]
    end

    def self.handle_has_one_association(association)
      [{ name: association.name, value: "#{association.klass}.create!(...)" }]
    end

    def self.handle_has_many_attached_association(association)
      [{ name: association.name, value: "[#{association.klass}.attach(...)]" }]
    end

    def self.handle_polymorphic_association(association)
      [
        { name: "#{association.name}_type", value: "'#{association.klass}'" },
        { name: "#{association.name}_id", value: "#{association.klass}.first.id" }
      ]
    end
  end
end
