require './lib/node'

class Trie
  attr_reader :base_node,
              :count,
              :selection_dictionary

  def initialize
    @base_node = Node.new
    @count = 0
    @selection_dictionary = {}
  end

  def insert(word)
    if base_node.has_links? && base_node.links[pull_first_letter(word)] != nil
      # binding.pry
      base_node.walk(word)
    elsif base_node.has_links?
      create_node_at_letter_link(word)
      nodes_link_to_base.last.insert_node(word)
    else
      create_node_at_letter_link(word)
      nodes_link_to_base.first.insert_node(word)
    end
    @count += 1
  end

  def has_links?
    links != ({})
  end

  def create_node_at_letter_link(word)
    base_node.links[pull_first_letter(word)] = Node.new
  end

  def pull_first_letter(word)
    word.chars.first
  end

  def nodes_link_to_base
    base_node.links.values
  end

  def populate(file_path)
    words = read_file(file_path)
    words.each do |word|
      word = word.downcase
      insert(word)
    end
  end

  def read_file(file_path)
    File.readlines(file_path).map do |word|
      word.chomp
    end
  end

  def suggest(stem)
    beginning = stem.dup
    suffixs = base_node.suggestion_walk(stem)
    # binding.pry
    suggestions = suffixs.map do |suffix|
      beginning + suffix
    end
    combine_arrays(beginning, suggestions)
  end

  def weight_selections(stem)
    # binding.pry
    weighted = selection_dictionary[stem].sort_by {|word, weight| weight} #array of arrays
    words_only = weighted.map do |word, weight|
      word
    end
    words_only
  end

  def combine_arrays(stem, suggestions)
    # binding.pry
    if selection_dictionary[stem] == nil
      suggestions
    else
      # binding.pry
    weight_selections(stem) | suggestions
  end
  end

  def select(stem, word)
    if selection_dictionary[stem]
      result = selection_dictionary[stem].find {|stems_values| stems_values[0] == word}
      if result == nil
        selection_dictionary[stem] << [word, 1]
      else
        result[1] += 1
      end
    else
      selection_dictionary[stem] = [[word, 1]]
    end
  end
end
