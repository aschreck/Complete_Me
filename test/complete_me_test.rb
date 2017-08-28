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

  def test_suggest
    skip
    completion= CompleteMe.new
    completion.insert('cat')
    completion.insert('calf')
    completion.insert('captive')
    completion.insert('captor')

    puts completion.suggest("ca")
    #our code is returning the last node for each path
  end

  def test_select
    completion= CompleteMe.new
    completion.insert('pi')
    completion.insert('pizza')
    completion.insert('pizzeria')
    completion.insert('pizzicato')
    completion.insert('pizzle')
    completion.insert('pize')

    completion.select('piz', 'pizzeria')
    completion.select('piz', 'pizzeria')
    #puts completion.suggest('piz')
    puts completion.suggest('pi')

  end
end
