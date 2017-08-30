require './test/test_helper'
require './lib/trie'
require 'csv'

class TrieTest < Minitest::Test

  def test_trie_exists
    assert_instance_of Trie, Trie.new
  end

  def test_it_initializes_with_root_and_zero_words
    trie = Trie.new
    assert_instance_of Node, trie.root
    assert_equal 0, trie.count
  end

  def test_root_knows_children
    trie = Trie.new
    assert_equal ({}), trie.root.children

    trie.insert('a')
    assert_equal ['a'], trie.root.children.keys
  end

  def test_insert_creates_nodes_with_populated_children_hashes
    trie = Trie.new
    trie.insert('cat')

    keys = []
    node = trie.root
    while node.children.length > 0
      keys << node.children.keys[0]
      node = node.children[node.children.keys[0]]
    end

    assert_equal ['c', 'a', 't'], keys
  end

  def test_count_increments_for_each_full_word_in_trie
    trie = Trie.new

    assert_equal 0, trie.count

    trie.insert('a')

    assert_equal 1, trie.count

    trie.insert('axe')
    trie.insert('axle')
    trie.insert('butter')

    assert_equal 4, trie.count
  end


  def test_insert_creates_only_necessary_nodes_and_flags_full_words
    trie = Trie.new
    trie.insert('denver')
    trie.insert('dentist')
    node = trie.root

    assert_equal 2, trie.count
    assert_equal 1, node.children.length
    assert_equal 'd', node.children.keys[0]

    3.times do
      node = node.children[node.children.keys[0]]
    end

    assert_equal ['v','t'], node.children.keys
  end

  def test_it_loads_dictionary
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    assert_equal 235886, trie.count
  end

  #add csv tests
  #refactor
  #check tests I wrote tonight...
  #data file
  #clean up prys, attr_,
  #anything with csv file? (can you do path from root of project file so it can be called from any computer?)
  #node.has_children? methd--test, see if you can insert elsewhere

end
