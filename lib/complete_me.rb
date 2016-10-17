require_relative 'node'

class Trie
  attr_reader :base_node,
              :count

  def initialize
    @base_node = Node.new
    @count = 0
  end

  def insert(word)
      if base_node.links != ({})
        if base_node.links[word.chars.first]
          base_node.walk(word)
        else 
          base_node.links[word.chars.first] = Node.new
          base_node.links.values.last.insert_node(word)
        end
      else
        base_node.links[word.chars.first] = Node.new
        base_node.links.values.first.insert_node(word)
      end
      @count += 1
  end
end

