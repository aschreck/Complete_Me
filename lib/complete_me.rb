require_relative "./trie"

class CompleteMe

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
    #add condition for if prefix is word.
    @prefix = prefix and return node if prefix.size == 0

    first_letter = prefix[0]
    node = node.children[first_letter]
    find_prefix(prefix[1..-1], node)

  end

  def complete_word(key, node)
    word = "#{@prefix}"
    word << key.first
    #+=?
    #missing break condition
    if node.children[key.first].flagged

      @suggestions << word

    else

      node = node.children[key.first]
      if node.children.empty?
        return
      else
        node.children.each do |key|

          complete_word(key, node)
        end
      end

    end
  end


  def rest_of_word(node)
    node.children.each do |key|
      complete_word(key, node)
    end
      #check for flag

  end

  def suggest(prefix)
    node = find_prefix(prefix) #should return last node of prefix
    rest_of_word(node)
    @suggestions
  end
end
