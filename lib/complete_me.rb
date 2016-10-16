class Trie
  attr_reader :base_node,
              :count

  def initialize
    @base_node = Node.new
    @count = 0
  end

  def insert(word)
      base_node.links[word.chars.first]= Node.new
      @count += 1
      # word.chars.shift
      base_node.links[word.chars.first].insert_node(word)
  end
end

class Node
  attr_reader :links, :terminator
  def initialize
    @links = {}
    @terminator = false
  end

  def insert_node(word)
    # until terminator == true
      word = delete_letter(word)
      # binding.pry
      if links[word.chars.first] && terminator == false
        links[word.chars.first].insert_node(word)
      elsif word == ""
        @terminator = true
      else
        # binding.pry
        links[word.chars.first] = Node.new
        links[word.chars.first].insert_node(word)
      end
    # end
  end

  def delete_letter(word)
    word.delete(word.chars.shift)
  end

  def links?
    links
  end
end
