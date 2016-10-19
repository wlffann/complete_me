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
      suffixs = ""
      self.links[saved].check_letters_for_links(suffixs)
    end
  end

  def check_letters_for_links(suffixs_mess)
    # binding.pry
    available_letters = self.links.keys
    available_letters.each do |letter|
      suffixs_mess << letter

      if self.links[letter].terminator == true && self.links[letter].has_links?
        # # binding.pry
        suffixs_mess << ","
        self.links[letter].check_letters_for_links(suffixs_mess)
      elsif self.links[letter].has_links?
        self.links[letter].check_letters_for_links(suffixs_mess)
      else
        suffixs_mess << ";"
      end
    end
    binding.pry
    clean_up(suffixs_mess)
  end

  def clean_up(suffixs_mess)
    # binding.pry
    suffixs_mess = suffixs_mess.split(";")
    suffixs = suffixs_mess.map do |thingie|
      thingie.delete(";")
      if thingie.include?(",")
        array = thingie.split(",")
        results = array.map do |thing|
          binding.pry
          thing = array[0]
          #need to make this work here
        end
        thingie << results
      else
        thingie
      end
    end
    suffixs.flatten
  end

  def delete_letter(word)
    word[0] = ""
    word
  end

  def pull_first_letter(word)
    word.chars.first
  end

end
