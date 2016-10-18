require 'pry'
class Node
  attr_reader :links, :terminator
  def initialize
    @links = {}
    @terminator = false
  end

  def insert_node(word)
    word = delete_letter(word)
    if empty?(word)
      end_word
    else
      assign_new_link_at_first_letter_of(word)
    end
  end

  def empty?(word)
    word == ""
  end

  def link_at_first_letter_of(word)
    links[pull_first_letter(word)]
  end

  def assign_new_link_at_first_letter_of(word)
    links[pull_first_letter(word)] = Node.new
    link_at_first_letter_of(word).insert_node(word)
  end

  def end_word
    @terminator = true
  end

  def walk(word)
    # binding.pry
    current = set_current_node(word)
    word = delete_letter(word)
    if keep_going?
      current.walk(word)
    else
      pass_word_to_next_method(word)
    end
  end

  def has_links?
    self.links != ({})
  end

  def keep_going?
    current.has_links? && current.link_at_first_letter_of(word)
  end

  def pass_word_to_next_method(suffix)
    if empty?(suffix)
      current.assign_new_link_at_first_letter_of(word)
    else
      collect_letters(suffix)
    end
  end

  # def collect_letters(suffix)
  #   suffixs = []
  #   #go down into each available
  #     until self.links == ({}) #at the end of the line
  #       letters = []
  #       # as it moves, saves the link's letter
  #       if terminator == true && self.links != ({}) #if it is the end of the word AND there are more links
  #         suffixs << letters.join
  #       elsif terminator == true && self.links == ({})
  #           suffixs << letter.join
  #           # else continue down until term == true && mo more links
  #       else #terminator == false
  #         #keep going
  #       end
  #     end
  #   end
  # end

  # suffixs = []
  # letters = []

  def check_letters_for_links(suffixs, letters)
    available_letters = self.links.keys
    # binding.pry
    available_letters.each do |letter|
      letters << letter
      if self.links[letter].links != ({})
        self.links[letter].check_letters_for_links(suffixs, letters)
        # binding.pry
      else
        # binding.pry
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
