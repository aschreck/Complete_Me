require_relative './node'

class Trie

  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word, node = @root)
    #write individual functions for each of these points
    if word.size == 0
      if node != @root
        node.flagged = true and return node
      else
        return nil
      end
    end
    first_letter = word[0]
    node.children[first_letter] = Node.new unless node.children.has_key?(first_letter)
    node = node.children[first_letter]
    insert(word[1..-1], node)
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
    path = 'data/addresses.csv'
    csv = CSV.read(path, :headers=> true)
    address_array = csv['FULL_ADDRESS']
    address_array.each do |address|
      addresses.write(address + "\n")
    end
    file = File.open('data/addresses.txt')
    populate(file)
  end

  # def pick_one_hundred_random_lines_from_txt_file
  #   test_data = File.new('data/test_data.txt', 'w+')
  #   100.times do
  #     data = File.readlines('data/addresses.txt').sample
  #     test_data.write(data)
  #   end
  # end

end
