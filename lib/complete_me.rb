require_relative 'node'

class Trie
  attr_reader :base_node,
              :count

  def initialize
    @base_node = Node.new
    @count = 0
  end

  def insert(word)
      if has_links? && base_node.links[pull_first_letter(word)]
        base_node.walk(word)
      elsif has_links?
        create_node_at_letter_link(word)
        nodes_link_to_base.last.insert_node(word)
      else
        create_node_at_letter_link(word)
        nodes_link_to_base.first.insert_node(word)
      end
      @count += 1
  end

  def has_links?
    base_node.links != ({})
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
    words = readfile(file_path)
  end

  def read_file(file_path)
    File.readlines(file_path).map do |word|
      word.chomp
    end
  end
end
