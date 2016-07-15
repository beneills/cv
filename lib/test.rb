require 'minitest/spec'
require 'minitest/autorun'

require_relative 'cv'

class Tests < Minitest::Test
  def test_unique_id
    assert_equal 'a-b-c', Internal::unique_id('a', 'b', 'c')
  end
end
