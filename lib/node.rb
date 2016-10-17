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
      links[pull_first_letter(word)] = Node.new
      links[pull_first_letter(word)].insert_node(word)
    end
  end

  def walk(word)
    # binding.pry
    current = set_current_node(word)
    word = delete_letter(word)
    if current.links != nil && current.links[pull_first_letter(word)]
      current.walk(word)
    else
      current.links[pull_first_letter(word)] = Node.new
      current.links[pull_first_letter(word)].insert_node(word)
    end
  end

  def collect_words(suggested_word)
    
  end

  def set_current_node(word)
    self.links[pull_first_letter(word)]
  end

  def delete_letter(word)
    word[0] = ""
    word
  end

  def pull_first_letter(word)
    word.chars.first
  end

end
