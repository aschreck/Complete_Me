require_relative './node'

class Trie

  attr_reader :root, :word_count

  def initialize
    @root = Node.new("")
    @word_count = 0
  end

  def insert(word, node = @root)
    #write individual functions for each of these points
    @word_count += 1 and node.flagged = true and return if word.size == 0
    first_letter = word[0]
    node.children[first_letter] = Node.new(first_letter) unless node.children.has_key?(first_letter)
    node = node.children[first_letter]
    insert(word[1..-1], node)
  end

  #do we need to include dictionary here?
  def populate(dictionary)
    dictionary.each_line do |word|
    word = word.chomp
    insert(word)
    end

  end


end
