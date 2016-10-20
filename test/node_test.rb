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
    node.declare("pizza")
    assert_equal ["p"], node.links.keys
  end

  def test_declares_words
    result = node.declare("pizza")
    assert_equal "pizza", result
  end

  def test_word_walks_down_tree
    node.declare("pizza")
    node.declare("pizzaz")
    node.walk(["p", "i", "z", "z", "a", "z"], 0)
    result =  node.links["p"].links.keys

    assert_equal ["i"], result

  end

  def test_it_can_return_words
    node.insert_node("bear".chars, 0)
    node.walk("beer".chars, 0)
    result = node.links["b"].return_words_at_terminator(suggestions = [])

    assert_equal ["bear", "beer"], result
  end

  def test_it_assigns_new_links_when_told
    node.assign_new_link_at_current(["p", "i", "z", "z", "a"], 0)
    result = node.links["p"].links.keys

    assert_equal ["i"], result
  end

  def test_ending_words
    node.end_word(["c", "a", "t"])
    assert_equal "cat", node.word
    assert_equal true, node.terminator
  end


end
