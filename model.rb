require 'erb'
require 'ostruct'
require 'yaml'

require './database'

class Model
  def initialize(attributes = {})
    self.attributes = attributes
  end

  def self.create(attributes = {})
    record = new(attributes)
    record.save
    record
  end

  def attributes
    @attributes ||= Hash[self.class.attribute_names.zip []]
  end

  def attributes=(new_attributes = {})
    filtered_attributes = new_attributes.select { |key, _| self.class.attribute_names.include? key }
    @attributes = self.attributes.merge(filtered_attributes)
  end

  def method_missing(name, *args)
    method_name = name.to_s
    attribute_name = method_name.chomp('=').to_sym

    if !self.class.attribute_names.include? attribute_name
      return super
    end

    if method_name.end_with?('=')
      @attributes[attribute_name] = args[0]
    else
      @attributes[attribute_name]
    end
    #puts "You called a nonexisting method #{name} with args #{args.inspect}"
  end

  def save
    file = 'data_model.yaml'
    if attributes[:id]
      Database.update file, self.attributes
    else
      self.id = Database.create file, self.attributes
    end
  end
end

class Snippet < Model
  def self.attribute_names
    [:id, :short, :long]
  end
end

i = Snippet.new
i.attributes = {short: "bla", foo: "bar"}
p i.short
i.short=5
p i.short
i.save