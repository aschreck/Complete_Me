require_relative './node'

class Trie

  attr_reader :root

  def initialize
    @root = Node.new("")
  end

  def insert(word, node = @root)
    #write individual functions for each of these points
    node.flagged = true and return if word.size == 0
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

  def count(node = @root)
    word_count = 0
    word_count += 1 if node.flagged

    node.children.each_value do |child|
        word_count += count(child)
    end
    word_count
  end

  #doesn't work on my computer--is this issue for instructor testing?
  def populate_from_csv
    addresses = File.new('addresses.txt', 'w+')
    path = '/Users/aaronschreck/turing/1mod/projects/Complete_Me/test/addresses.csv'
    csv = CSV.read(path, :headers=> true)
    address_array = csv['FULL_ADDRESS']
    address_array.each do |address|
      addresses.write(address + "\n")
    end
    file = File.open('addresses.txt')
    populate(file)
  end

end
