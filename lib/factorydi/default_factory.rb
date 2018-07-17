# frozen_string_literal: true

class DefaultFactory
  attr_accessor :name

  def initialize name
    @name = name
  end

  def create
    class_name = to_camel(name.to_s).gsub('Factory', '')
    Object.const_get(class_name).new
  end

  private

  def to_camel(str)
    str.split("_").map { |w| w[0] = w[0].upcase; w }.join
  end

end
