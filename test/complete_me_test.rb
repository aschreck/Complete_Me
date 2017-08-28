require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def test_insert_adds_child_nodes_and_raises_word_count
    completion= CompleteMe.new

    assert_equal ({}), completion.trie.root.children

    completion.insert('cat')

    assert_equal 1 ,completion.count
    assert_equal ['c'], completion.trie.root.children.keys
  end

  def test_count_increments_when_words_are_added
    completion= CompleteMe.new

    assert_equal 0, completion.count

    completion.insert('cat')
    completion.insert('car')

    assert_equal 2, completion.count
  end

  # def test_populate_adds_dictionary_words
  #   completion= CompleteMe.new
  #   dictionary = File.read("/usr/share/dict/words")
  #   completion.populate(dictionary)
  #
  #   assert_equal 235886, completion.count
  # end

  def test_find_prefix_iterates_to_last_node_and_returns_node
    completion = CompleteMe.new
    completion.insert('captive')
    node = completion.find_prefix('ca')

    assert_instance_of Node, node
    assert_equal ['p'], node.children.keys
  end

  def test_complete_word
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')

    assert completion.find_prefix('captive').flagged
    refute completion.find_prefix('captiv').flagged
  end

  # def test_rest_of_word_completes_word
  #   completion = CompleteMe.new
  #   completion.insert('rollercoaster')
  #   node = completion.find_prefix('ro')
  #
  #   completion.rest_of_word(node, )
  # end

  def test_select_flags_chosen_prefixes_and_weights_chosen_words
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    completion.insert('capuccino')
    completion.select('ca', 'captive')

    assert completion.find_prefix('ca').prefix_selected?
    refute completion.find_prefix('c').prefix_selected?
    assert_equal 1, completion.find_prefix('captive').weight

    completion.select('ca', 'captive')

    assert_equal 2, completion.find_prefix('captive').weight

  end


  def test_suggest_lists_unweighted_suggestions_based_on_unchosen_prefixes
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    completion.insert('capuccino')

    assert_equal ['cap', 'cappucino', 'captive', 'captor'], completion.suggest('ca')
    #test cap as prefix
  end

  def test_suggest_lists_weighted_suggestions_based_on_prefixes_already_chosen
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    completion.insert('capuccino')

    completion.select('ca', 'captive')
    completion.select('ca', 'captive')

    assert_equal ['captive', 'cap', 'cappucino', 'captor'], completion.suggest('ca')
    assert_equal ['cap', 'cappucino', 'captive', 'captor'], completion.suggest('c')
  end


  # def test_suggest
  #   skip
  #   completion= CompleteMe.new
  #   completion.insert('cat')
  #   completion.insert('calf')
  #   completion.insert('captive')
  #   completion.insert('captor')
  #
  #   puts completion.suggest("ca")
  #   #our code is returning the last node for each path
  # end
  #
  # def test_select
  #   completion= CompleteMe.new
  #   completion.insert('pi')
  #   completion.insert('pizza')
  #   completion.insert('pizzeria')
  #   completion.insert('pizzicato')
  #   completion.insert('pizzle')
  #   completion.insert('pize')
  #
  #   completion.select('piz', 'pizzeria')
  #   completion.select('piz', 'pizzeria')
  #   p completion.suggest('piz')
  #   p completion.suggest('pi')
  #
  # end
end
