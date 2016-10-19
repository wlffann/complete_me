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

  def assign_new_link_at_first_letter_of(word)
    # binding.pry
    links[pull_first_letter(word)] = Node.new
    links[pull_first_letter(word)].insert_node(word)
  end

  def assign_new_link_at_lower_level(word)
    # binding.pry
    link_corresponding_to_first_lettter = self.links[pull_first_letter(word)]
    self.links[pull_first_letter(word)].assign_new_link_at_first_letter_of(word)
  end

  def end_word
    @terminator = true
  end

  def walk(word)
    current = set_current_node(word)
    saved = pull_first_letter(word)
    word = delete_letter(word)
    if current.has_links? && current.link_at_first_letter_of(word) != nil
      current.walk(word)
    else
      pass_word_to_next_method(word, saved)
    end
  end

  def set_current_node(word)
    self.links[pull_first_letter(word)]
  end

  def has_links?
    links != ({})
  end

  def link_at_first_letter_of(word)
    links[pull_first_letter(word)]
  end

  def pass_word_to_next_method(word, saved)
    if self.links[pull_first_letter(word)] != nil
      self.assign_new_link_at_lower_level(word)
    else
      self.links[saved].assign_new_link_at_first_letter_of(word)
    end
  end

## suggest section
  def suggestion_walk(stem)
    current = set_current_node(stem)
    saved = pull_first_letter(stem)
    stem = delete_letter(stem)
    # binding.pry
    if stem != "" && current.link_at_first_letter_of(stem) != nil
      current.suggestion_walk(stem)
    else
      suffixs = []
      letters = []
      self.links[saved].check_letters_for_links(suffixs, letters)
    end
  end

  def check_letters_for_links(suffixs, letters)
    # binding.pry
    available_letters = self.links.keys
    available_letters.each do |letter|
      letters << letter
    
      if self.links[letter].terminator == true && self.links[letter].has_links?
        # # binding.pry
        suffixs << letters.join
        # self.links[letter].check_letters_for_links(suffixs, letters)
        # letters = [letters[0]]
      elsif self.links[letter].has_links?
        # binding.pry
        # self.links[letter].check_letters_for_links(suffixs, letters)
      else
        suffixs << letters.join
      end
    end
    suffixs
  end

  def delete_letter(word)
    word[0] = ""
    word
  end

  def pull_first_letter(word)
    word.chars.first
  end

end
