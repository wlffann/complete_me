require 'pry'
class Node
  attr_reader :links, :terminator
  def initialize
    @links = {}
    @terminator = false
  end

  def insert_node(word)
    word = delete_letter(word)
    if word == ""
      @terminator = true
    else
      links[word.chars.first] = Node.new
      links[word.chars.first].insert_node(word)
    end
  end

  def walk(word)
    current = self.links[word.chars.first]
    word = delete_letter(word)
    if current.links != nil && current.links[word.chars.first]
      current.walk(word)
    else 
      current.links[word.chars.first] = Node.new
      current.links[word.chars.first].insert_node(word)
    end
  end

  def delete_letter(word)
    word[0] = ""
    word
  end

end