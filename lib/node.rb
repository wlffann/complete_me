require 'pry'
class Node
  attr_reader :links, :terminator, :word
  def initialize
    @links = {}
    @terminator = false
    @word = ""
  end

  def declare(word)
    word_split = word.chars
    index = 0
    walk_or_insert(word_split, index)
  end

  def walk_or_insert(word_split, index)
    if self.links[word_split[index]] == nil
      assign_new_link_at_current(word_split, index)
    else
      self.walk(word_split, index)
    end
  end

  def insert_node(word_split, index)
    letter = word_split[index]
    if letter == nil
      end_word(word_split)
    else
      assign_new_link_at_current(word_split, index)
    end
  end

  def assign_new_link_at_current(word_split, index)
    links[word_split[index]] = Node.new
    links[word_split[index]].insert_node(word_split, index += 1)
  end

  def end_word(word_split)
    @terminator = true
    @word = word_split.join
  end

  def walk(word_split, index)
    current = self.links[word_split[index]]
    if current.links[word_split[index + 1]] == nil
      current.links[word_split[index + 1]] = Node.new
      current.links[word_split[index + 1]].insert_node(word_split, index + 2)
    else
      current.walk(word_split, index + 1)
    end
  end

  def has_links?
    links != ({})
  end

  def suggest_declare(stem)
    stem_split = stem.chars
    index = 0
    self.suggestion_walk(stem_split, index)
  end

  def suggestion_walk(stem_split, index)
    current = self.links[stem_split[index]]
    if stem_split[index + 1]
      current.suggestion_walk(stem_split, index + 1)
    else
      suggestions = current.return_words_at_terminator(suggestions = [])
      suggestions
    end
  end

  def return_words_at_terminator(suggestions)
    available_letters = self.links.keys
    available_letters.each do |letter|
      if self.word != "" && self.links != ({})
        suggestions << self.word
        self.links[letter].return_words_at_terminator(suggestions)
      elsif self.links[letter].has_links?
        self.links[letter].return_words_at_terminator(suggestions)
      else
        suggestions << self.links[letter].word
      end
    end
    suggestions
  end

end
