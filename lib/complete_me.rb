require './lib/node'

class Trie
  attr_reader :base_node,
              :count

  def initialize
    @base_node = Node.new
    @count = 0
  end

  def insert(word)
    if base_node.has_links? && base_node.links[pull_first_letter(word)] != nil
      base_node.walk(word)
    elsif base_node.has_links?
      create_node_at_letter_link(word)
      nodes_link_to_base.last.declare(word)
    else
      create_node_at_letter_link(word)
      nodes_link_to_base.first.declare(word)
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
    suggestions = suffixs.map do |suffix|
      beginning + suffix
    end
    suggestions
  end
end
