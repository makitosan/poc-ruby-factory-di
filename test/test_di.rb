# frozen_string_literal: true

require 'minitest/autorun'

require 'factorydi/factory_container'

class TestDi < Minitest::Test
  describe 'TestDi' do
    before do
      @fc = FactoryContainer.instance
      @fc.reset
    end

    it 'initialize ' do
      assert_equal false, @fc.nil?
    end

    it 'new my with factory' do
      require 'factorydi/factories/my_factory'
      require 'factorydi/models/my'
      my = @fc.get(:my_factory).create
      assert_equal 'My', my.name

    end

    it 'new original without factory' do
      require 'factorydi/models/original'
      o = @fc.get(:original_factory).create
      assert_equal 'my name is Original', o.name
    end

    it 'new original without factory and replace it with a mocked factory' do
      require 'factorydi/models/original'
      require 'factorydi/models/my'
      factory = @fc.get(:original_factory)
      o = factory.create
      assert_equal 'my name is Original', o.name

      my = My.new
      my.title = 'CEO'

      mocked_factory = MiniTest::Mock.new.expect(:create, my) # create mock
      @fc.factories[:original_factory] = mocked_factory # replace original_factory
      o = @fc.get(:original_factory).create
      assert_equal 'CEO', o.title
      assert_equal 'My', o.name

    end
  end
end
