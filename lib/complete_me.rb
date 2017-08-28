require_relative "./trie"
require 'pry'

class CompleteMe

  attr_reader :trie

  def initialize
    @trie = Trie.new
    @prefix = ''
    @suggestions =[]
  end

  def insert (word, node = @trie.root)
    @trie.insert(word, node)
  end

  def count
    @trie.word_count
  end


  def populate (dictionary)
    @trie.populate (dictionary)
  end

  def find_prefix(prefix, node = @trie.root)

    return node if prefix.size == 0
    first_letter = prefix[0]
    node = node.children[first_letter]
    find_prefix(prefix[1..-1], node)

  end

  def complete_word(key, node, word)
    word += key.first
    node = node.children[key.first]

    if node.children.empty? #and if node.flagged
        @suggestions << word

    else
      @suggestions << word if node.flagged

        node.children.each do |key|
          complete_word(key, node, word)
        end

    end
  end


  def rest_of_word(node, prefix)
    node.children.each do |key|
      complete_word(key, node, word = @prefix)
    end
  end

  def suggest(prefix)
    @prefix = prefix
    node = find_prefix(prefix) #should return last node of prefix
    rest_of_word(node, prefix)
    @suggestions = @suggestions.sort

    if node.prefix_selected?
      weights = @suggestions.map {|suggestion| find_prefix(suggestion).weight}
      suggestion_weights = Hash[@suggestions.zip(weights)]
      ordered_suggestions = Hash[suggestion_weights.sort_by{|word, weight| weight}.reverse]
      final_suggestions = ordered_suggestions.keys
    else
      @suggestions
    end
  end

  def select(prefix, word_choice)
    #prefix counter here?
    prefix = find_prefix(prefix)
    prefix.prefix_selected = true

    node = find_prefix(word_choice) #find node at end of word selection-rename find_prefix?
    node.weight += 1
  end
end
