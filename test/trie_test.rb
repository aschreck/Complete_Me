require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/trie'

class TrieTest < Minitest::Test

  def test_it_exists
    assert_instance_of Trie, Trie.new
  end

  def test_it_initializes_with_root_and_zero_words
    trie = Trie.new
    assert_instance_of Node, trie.root
    assert_equal 0, trie.word_count
  end

  def test_root_knows_children
    trie = Trie.new
    assert_equal ({}), trie.root.children

    trie.insert('a')
    assert_equal 'a', trie.root.children.keys[0]
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

  def test_insert_creates_only_necessary_nodes_and_increases_count
    trie = Trie.new
    trie.insert('denver')
    trie.insert('dentist')
    node = trie.root

    assert_equal 2, trie.word_count
    assert_equal 1, node.children.length
    assert_equal 'd', node.children.keys[0]

    3.times do
      node = node.children[node.children.keys[0]]
    end

    assert_equal ['v','t'], node.children.keys
  end

  # def test_it_loads_dictionary
  #   trie = Trie.new
  #   dictionary = File.read("/usr/share/dict/words")
  #   trie.populate(dictionary)

  #   assert_equal 235886, trie.word_count
  # end
end
