# frozen_string_literal: true

require 'singleton'

class String
  def to_camel()
    self.split("_").map { |w| w[0] = w[0].upcase; w }.join
  end
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
    @factories[name] = Object.const_get(name.to_s.to_camel).new do |c|
      class_name = c.class.name.gsub('Factory', '')
      Object.const_get(class_name).new
    end
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
