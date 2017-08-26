require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/trie'

class TrieTest < Minitest::Test

  def test_it_exists
    trie = Trie.new
    assert_instance_of Trie, trie
  end

  def test_it_initializes_with_root
    trie = Trie.new
    refute_nil trie.root
    assert_instance_of Node, trie.root
  end

  def test_root_knows_children
    trie = Trie.new
    assert_equal ({}), trie.root.children
  end

  def test_insert_works
    trie = Trie.new
    trie.insert('denver')
    children = trie.root.children
    assert_instance_of Hash, children
    refute children.empty?
  end

  def test_insert_works_with_multiple_words
    trie = Trie.new
    trie.insert('denver')
    trie.insert('dentist')
    assert_equal 2, trie.word_count
    trie.insert('cat')
    trie.insert('dog')
    assert_equal 4, trie.word_count
    assert_equal 2, trie.root.children.length
  end
end
