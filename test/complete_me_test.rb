require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def test_complete_me_insert
    completion= CompleteMe.new
    completion.insert('cat')
    completion.insert('calf')
    completion.insert('captive')
    completion.insert('captor')

    assert_equal 4 ,completion.count

  end

  def test_select
    completion= CompleteMe.new
    completion.insert('cat')
    completion.insert('calf')
    completion.insert('captive')
    completion.insert('captor')

    puts completion.suggest("ca")

  end
end
