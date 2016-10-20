require 'pry'
class Node
  attr_reader :links, :terminator
  def initialize
    @links = {}
    @terminator = false
    @word = ""
  end

  def declare(word)
    word_split = word.chars
    index = 1
    self.insert_node(word_split, index)
  end

  def insert_node(word_split, index)
    letter = word_split[index]
    if self.links[letter] == nil
      end_word(word_split)
    else
      assign_new_link_at_current(letter, index)
    end
  end

  def empty?(word)
    word == ""
  end

  def assign_new_link_at_current(letter, index)
    links[index] = Node.new
    links[index].insert_node(word_split, index += 1)
  end

  def assign_new_link_at_lower_level(word)
    link_corresponding_to_first_lettter = self.links[pull_first_letter(word)]
    self.links[pull_first_letter(word)].assign_new_link_at_first_letter_of(word)
  end

  def end_word(word_split)
    @terminator = true
    @word = word_split.join
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
    # binding.pry
    stem = delete_letter(stem)
    if stem != "" && current.link_at_first_letter_of(stem) != nil
      current.suggestion_walk(stem)
    else
      suffixs = []
      letters = []
      # binding.pry
      self.links[saved].check_letters_for_links(suffixs, letters)
      # binding.pry
    end
  end

  def check_letters_for_links(suffixs, letters)
    # binding.pry
    available_letters = self.links.keys
    available_letters.each do |letter|
      letters << letter

      if self.links[letter].has_links?
        # binding.pry
        self.links[letter].check_letters_for_links(suffixs, letters)
      else
        suffixs << letters.join
      end
      letters = []
    end
    suffixs
  end

end
