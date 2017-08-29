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

  #.count after populate and one insert returns one extra word--is this problem??

  # def test_populate_adds_dictionary_words
  #   completion= CompleteMe.new
  #   dictionary = File.read("/usr/share/dict/words")
  #   completion.populate(dictionary)s
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

  def test_rest_of_word_completes_word_and_returns_array_with_word
    completion = CompleteMe.new
    completion.insert('rollercoaster')
    node = completion.find_prefix('ro')

    assert_equal ['rollercoaster'], completion.rest_of_word(node, 'ro')
  end

  def test_select_flags_chosen_prefixes_and_weights_chosen_words
    #test for misspelling?
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    completion.insert('cappuccino')
    completion.select('ca', 'captive')

    assert completion.find_prefix('ca').prefix_selected?
    refute completion.find_prefix('c').prefix_selected?
    assert_equal 1, completion.find_prefix('captive').weight

    completion.select('ca', 'captive')

    assert_equal 2, completion.find_prefix('captive').weight

  end

  def check_array_for_desired_values(completion, suggestions)
  suggestions = completion.suggest('ca')
  suggestions.each {|suggestion| suggestion.include?('cap')}
  suggestions.each {|suggestion| suggestion.include?('cappuccino')}
  suggestions.each {|suggestion| suggestion.include?('captive')}
  suggestions.each {|suggestion| suggestion.include?('captor')}
  end

  def test_suggest_lists_unweighted_suggestions_based_on_unchosen_prefixes
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    completion.insert('cappuccino')
    completion.insert('dog')
    suggestions = completion.suggest('ca')

    assert_equal 4, suggestions.length
    assert check_array_for_desired_values(completion, suggestions)
    refute suggestions.include?('dog')

    suggestions = completion.suggest('cap')

    assert check_array_for_desired_values(completion, suggestions)

  end

#crap!! weighting is still added even with other prefixes so weight for substrings is off
  def test_suggest_lists_weighted_suggestions_based_on_prefixes_already_chosen
    #doesn't seem to include word itself? should it?
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    completion.insert('cappuccino')

    completion.select('ca', 'captive')
    completion.select('ca', 'captive')

    assert_equal 'captive', completion.suggest('ca').first
    assert_equal 2, completion.find_prefix('captive').weight

    completion.select('ca', 'cappuccino')

    assert_equal 'captive', completion.suggest('ca').first
    assert_equal 2, completion.find_prefix('captive').weight

  end
end
