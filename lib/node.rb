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
      create_new_node_if_still_word(word)
    end
  end

  def create_new_node_if_still_word(suffix)
    if suffix != ""
      current.links[pull_first_letter(suffix)] = Node.new
      current.links[pull_first_letter(suffix)].insert_node(word)
    else
      collect_letters(suffix)
    end

  def collect_letters(suffix)
    suffixs = []
    #go down into each available
      until self.links == ({}) #at the end of the line
        letters = []
        # as it moves, saves the link's letter
        if terminator == true && self.links != ({}) #if it is the end of the word AND there are more links
          suffixs << letters.join
        elsif terminator == true && self.links == ({})
            suffixs << letter.join
            # else continue down until term == true && mo more links
        else #terminator == false
          #keep going
        end
      end
    end
  end

  suffixs = []
  letters = []

  def check_letters_for_links(suffixs, letters)
    available_letters = self.links.keys
    # binding.pry
    available_letters.each do |letter|
      letters << letter
      if self.links[letter].links != ({})
        self.links[letter].check_letters_for_links(suffixs, letters)
        # binding.pry
      else
        binding.pry
        suffixs << letters.join
      end
    end
    suffixs
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
