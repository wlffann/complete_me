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

