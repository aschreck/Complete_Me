require_relative "./trie"
require 'CSV'
require 'pry'

class CompleteMe

  attr_reader :trie

  def initialize
    @trie = Trie.new
  end

  def insert (word, node = @trie.root)
    @trie.insert(word, node)
  end

  def count
    @trie.count
  end


  def populate (dictionary)
    @trie.populate (dictionary)
  end


  def populate_from_csv
    @trie.populate_from_csv
  end


  def find_prefix(prefix, node = @trie.root)

    return node if prefix.size == 0
    first_letter = prefix[0]
    node = node.children[first_letter]
    return nil if node == nil
    find_prefix(prefix[1..-1], node)

  end

  def complete_word(key, node, word, suggestions = [])
    return nil if node == nil
    word += key.first
    node = node.children[key.first]

    if node.children.empty?
        suggestions << word

    else
      suggestions << word if node.flagged

        node.children.each do |key|
          complete_word(key, node, word, suggestions)
        end

    end
    suggestions
  end


  def collect_all_words(node, prefix, suggestions = [])
    return [] if node == nil
    suggestions << prefix if node.flagged

    suggestions << node.children.map do |key|
      complete_word(key, node, word = prefix)
    end
    suggestions.flatten
  end

  def suggest(prefix)
    node = find_prefix(prefix)
    return [] if node == nil

    if node.prefix_weights.empty?
      suggestions = collect_all_words(node, prefix)
    else
      ordered_weights = Hash[node.prefix_weights.sort_by{|word, weight| weight}.reverse]
      suggestions = ordered_weights.keys
    end
    suggestions
  end

  def create_suggestion_weights(node, suggestions)
    return nil if node == nil
    node.prefix_weights = Hash[suggestions.map {|suggestion| [suggestion, 0]}]
  end

  def select(prefix, word_choice)
    node = find_prefix(prefix)
    return nil if node == nil
    suggestions = collect_all_words(node, prefix)

    if node.prefix_weights.empty?
      weights = create_suggestion_weights(node, suggestions)
      return nil if weights[word_choice] == nil
      weights[word_choice] += 1
    else
      return nil if node.prefix_weights[word_choice] == nil
      node.prefix_weights[word_choice] += 1
    end
  end


end
