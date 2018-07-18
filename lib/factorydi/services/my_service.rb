# frozen_string_literal: true
#
require_relative '../factory_container'
require_relative '../factories/my_factory'
require_relative '../models/my'

class MyService
  def run
    m = FactoryContainer.instance.get(:my_factory).create
    m.title
  end
end
