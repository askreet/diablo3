require 'forwardable'

class Diablo3
  # A Container wraps multiple items in a group, with a restiction on what it
  # can contain, as well as helper methods to search it's elements by
  # appropriate attributes.
  class Container
    extend Forwardable
    def_delegators :@objects, :map, :each, :first, :last, :sort, :sort_by, :size

    def self.contains(contained_class)
      @contained_class = contained_class
    end

    # Define one_by_* methods for the container.
    def self.find_by(*attributes)
      attributes.each do |attribute|
        define_method("by_#{attribute}".to_sym) do |value|
          @objects.find do |object|
            object.send(attribute) == value
          end
        end

        @unique_constraints ||= []
        @unique_constraints << attribute
      end
    end

    # Define all_by_* and first_by_* methods for the container.
    def self.find_many_by(*attributes)
      attributes.each do |attribute|
        define_method("all_by_#{attribute}".to_sym) do |value|
          @objects.select { |o| o.send(attribute) == value }
        end

        define_method("first_by_#{attribute}".to_sym) do |value|
          @objects.find { |o| o.send(attribute) == value }
        end
      end
    end

    def initialize
      @objects = []
    end

    def add(object)
      unless object.is_a? contained_class
        fail TypeError, "#{object.class} is not a #{contained_class}"
      end

      unique_constraints.each do |constraint|
        value = object.send(constraint)
        if send("by_#{constraint}", value)
          fail ArgumentError, "#{constraint} #{value} already in container"
        end
      end

      @objects << object
    end

    private

    def contained_class
      self.class.instance_variable_get('@contained_class')
    end

    def unique_constraints
      self.class.instance_variable_get('@unique_constraints')
    end
  end
end
