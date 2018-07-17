# frozen_string_literal: true

require 'singleton'
require_relative 'default_factory'

class FactoryContainer
  include Singleton

  attr_reader :factories

  def initialize
    @factories = {}
  end

  def get(name)
    @factories[name] || initialize_factory(name)
  end

  def reset
    initialize
  end

  def initialize_factory(name)
    if class_exists?(to_camel(name.to_s))
      @factories[name] = Object.const_get(to_camel(name.to_s)).new do |c|
        class_name = c.class.name.gsub('Factory', '')
        Object.const_get(class_name).new
      end
    else
      # use DefaultFactory for undefined factory classes
      @factories[name] = DefaultFactory.new name
    end
  end

  private

  def to_camel(str)
    str.split("_").map { |w| w[0] = w[0].upcase; w }.join
  end

  def class_exists?(class_name)
    klass = Module.const_get(class_name)
    return klass.is_a?(Class)
  rescue NameError
    return false
  end
end
