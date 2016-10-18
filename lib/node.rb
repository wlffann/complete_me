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
    # binding.pry
    links[pull_first_letter(word)] = Node.new
    links[pull_first_letter(word)].insert_node(word)
  end

  def assign_new_link_at_lower_level(word)
    # binding.pry
    self.links[pull_first_letter(word)].assign_new_link_at_first_letter_of(word)
  end

  def end_word
    @terminator = true
  end

  def walk(word)
    current = set_current_node(word)
    saved = pull_first_letter(word)
    word = delete_letter(word)
    # binding.pry
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

  def pass_word_to_next_method(suffix, saved)
    #  binding.pry
    if empty?(suffix)
      suffixs = []
      letters = []
      check_letters_for_links(suffixs, letters)
    elsif self.links[pull_first_letter(suffix)] != nil
      self.assign_new_link_at_lower_level(suffix)
    else
      self.links[saved].assign_new_link_at_first_letter_of(suffix)
    end
  end

  def check_letters_for_links(suffixs, letters)
    available_letters = self.links.keys
    available_letters.each do |letter|
      letters << letter
      if self.links[letter].has_links?
        self.links[letter].check_letters_for_links(suffixs, letters)
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
