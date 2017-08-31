require_relative './node'

class Trie

  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word, node = @root)
    node.flagged = true and return node if end_of_word?(word, node)
    return nil if input_empty_string?(word, node)

    node = create_word_nodes(word, node)
    insert(word[1..-1], node)
  end

  def create_word_nodes(word, node)
    first_letter = word[0]
    children = node.children
    children[first_letter] = Node.new unless children.has_key?(first_letter)
    node = children[first_letter]
  end

  def end_of_word?(word, node)
    word.size == 0 and node != @root
  end

  def input_empty_string?(word, node)
    word.size == 0 and node == @root
  end

  def populate(dictionary)
    dictionary.each_line do |word|
    word = word.chomp
    insert(word)
    end
  end

  def count(node = @root)
    word_count = 0
    word_count += 1 if node.flagged

    node.children.each_value do |child|
        word_count += count(child)
    end
    word_count
  end

  def create_addresses_file_from_csv
    addresses = File.new('data/addresses.txt', 'w+')
    csv = CSV.read('data/addresses.csv', :headers=> true)

    csv['FULL_ADDRESS'].each do |address|
      addresses.write(address + "\n")
    end
    populate(File.open('data/addresses.txt'))
  end

end
