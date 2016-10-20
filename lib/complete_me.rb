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
    base_node.declare(word)
    @count += 1
  end

  def has_links?
    links != ({})
  end

  def populate(string)
    list = string.split("\n")
    list.each do |word|
      word = word.downcase
      insert(word)
    end
  end

  def populate_from_file(file_path)
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
    suggestions = base_node.suggest_declare(stem)
    selections = pull_words_only(stem)
    suggestions = selections | suggestions
  end

  def pull_words_only(stem)
    if selection_dictionary[stem]
      selection_dictionary[stem].map do |letter, weight|
        letter
      end
    else 
      []
    end
  end


  def select(stem, word)
    if selection_dictionary[stem]
      result = selection_dictionary[stem].find {|stems_values| stems_values[0] == word}
      if !result
        selection_dictionary[stem] << [word, 1]
      else
        result[1] += 1
      end
    else
      selection_dictionary[stem] = [[word, 1]]
    end
  end
end
