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
    trie.insert('bork')
    trie.insert('taco')
    assert_equal 6 , trie.word_count
  end

  def test_it_loads_dictionary
    trie = Trie.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)
    assert_equal 235886, trie.word_count

  end
end
