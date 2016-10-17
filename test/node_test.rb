gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/complete_me'

class NodeTest < Minitest::Test

  attr_reader :node

  def setup
    @node = Node.new
  end

  def test_it_exsists
    assert node
  end
  
  def test_its_links_are_empty_hash
    assert_equal({}, node.links)
  end

  def test_it_has_links
    node.insert_node("pizza")
    assert_equal ["i"], node.links.keys
  end

  def test_it_deletes_first_words
    result = node.delete_letter("pizza")
    assert_equal "izza", result 
  end

end