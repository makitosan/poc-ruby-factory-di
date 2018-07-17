# frozen_string_literal: true

require 'singleton'

class String
  def to_camel()
    self.split("_").map { |w| w[0] = w[0].upcase; w }.join
  end
end

def class_exists?(class_name)
  klass = Module.const_get(class_name)
  return klass.is_a?(Class)
rescue NameError
  return false
end

class FactoryContainer
  include Singleton

  attr_reader :factories

  def initialize
    @factories = {}
  end

  def get(name)
    @factories[name] || initialize_factory(name)
  end

  def initialize_factory(name)
    if class_exists?(name.to_s.to_camel)
      @factories[name] = Object.const_get(name.to_s.to_camel).new do |c|
        class_name = c.class.name.gsub('Factory', '')
        Object.const_get(class_name).new
      end
    else
      # use DefaultFactory for undefined factory classes
      @factories[name] = DefaultFactory.new name
    end
  end
end

class DefaultFactory
  attr_accessor :name

  def initialize name
    @name = name
  end

  def create
    class_name = name.to_s.to_camel.gsub('Factory', '')
    Object.const_get(class_name).new
  end
end

class BaseFactory
  def initialize &b
    @block = b
  end

  def create
    @block.call(self)
  end
end

class MyFactory < BaseFactory
end

class OriginalFactory
  def create
    Original.new
  end
end

class My
  attr_accessor :title

  def name
    self.class.name
  end
end

class Original
  def name
    "my name is #{self.class.name}"
  end
end

class Hoge

end

class HogeService

end

fa = FactoryContainer.instance.get(:my_factory)
puts fa.create.name
puts fa.create.title.nil?

# replace my_factory
class DummyFactory
  def create
    instance = My.new
    instance.title = 'CEO'
    instance
  end
end

FactoryContainer.instance.factories[:my_factory] = DummyFactory.new
fa = FactoryContainer.instance.get(:my_factory)
puts fa.create.name
puts fa.create.title


ofa = FactoryContainer.instance.get(:original_factory)
puts ofa.create.name

dfa = FactoryContainer.instance.get(:hoge_factory)
puts dfa
puts dfa.create
