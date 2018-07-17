# frozen_string_literal: true

class BaseFactory
  def initialize &b
    @block = b
  end

  def create
    @block.call(self)
  end
end
