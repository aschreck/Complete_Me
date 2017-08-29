require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def test_insert_adds_child_nodes_and_raises_word_count
    completion= CompleteMe.new
    root = completion.trie.root

    assert_equal ({}), root.children

    completion.insert('cat')

    assert_equal 1 ,completion.count
    assert_equal ['c'], root.children.keys
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

  def test_complete_word_collects_node_keys_as_string_returned_as_words_in_array
    completion = CompleteMe.new
    completion.insert('captive')
    node = completion.find_prefix('cap')
    key = node.children.keys
    word = 'cap'
    suggestions = completion.complete_word(key, node, word)

    assert_equal ['captive'], suggestions
  end

  def test_collect_all_words_returns_array_with_every_full_word_from_starter_node
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    node = completion.find_prefix('cap')
    suggestions = completion.collect_all_words(node, 'cap')

    assert_instance_of Array, suggestions
    assert suggestions.include?('cap')
    assert suggestions.include?('captive')
    assert suggestions.include?('captor')
    assert_equal 3, suggestions.length

  end

  def test_create_suggestion_weights_creates_hash_with_suggestions_as_keys
    completion = CompleteMe.new
    completion.insert('captor')
    completion.insert('cap')
    node = completion.find_prefix('cap')
    suggestions = ['cap', 'captor']

    assert_equal ({'cap' => 0, 'captor'=> 0}), completion.create_suggestion_weights(node, suggestions)
  end

  def test_select_creates_or_edits_selection_hash_with_weight_for_chosen_word
    #test for misspelling or word not inserted?
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')
    node = completion.find_prefix('ca')

    assert node.prefix_weights.empty?

    completion.select('ca', 'captive')

    refute node.prefix_weights.empty?
    assert_equal 1, node.prefix_weights['captive']

    completion.select('ca', 'captive')

    assert_equal 2, node.prefix_weights['captive']
    assert_equal 0, node.prefix_weights['cap']
  end

  def test_suggest_lists_unweighted_suggestions
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('cap')
    completion.insert('captor')
    completion.insert('dog')
    suggestions = completion.suggest('ca')

    assert_equal 3, suggestions.length
    assert suggestions.include?('captive')
    assert suggestions.include?('cap')
    assert suggestions.include?('captor')
    refute suggestions.include?('dog')

  end

  def test_suggest_lists_weighted_suggestions_based_on_selected_prefixes
    completion = CompleteMe.new
    completion.insert('captive')
    completion.insert('captor')
    completion.insert('cap')

    completion.select('cap', 'captive')
    completion.select('cap', 'captive')

    assert_equal 'captive', completion.suggest('cap').first
    assert_equal 2, completion.find_prefix('cap').prefix_weights['captive']

    completion.select('ca', 'cap')

    assert_equal 'cap', completion.suggest('ca').first
    assert_equal 0, completion.find_prefix('ca').prefix_weights['captive']
    assert_equal 1, completion.find_prefix('ca').prefix_weights['cap']
  end


end
