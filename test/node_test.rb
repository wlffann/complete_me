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
    assert_equal ["i"], node.links.keys
  end

  def test_declares_words
    result = node.declare("pizza")
    assert_equal "pizza", result
  end

  def test_word_walks_down_tree
    node.declare("pizza")
    node.declare("pizzaz")
    node.walk(["p", "i", "z", "z", "a", "z"], 2)
    result =  node.links.keys

    assert_equal ["i"], result

  end

  def test_it_can_return_a_word
    skip
    result = node.collect_words("iz")
    assert_equals ["izza", "izzeria"], result
  end

  def test_check_letters_for_links
    node.insert_node("bear")
    node.walk("ehr")
    
    suffixs = []
    letters = []
    result = node.links["e"].check_letters_for_links(suffixs, letters)

    assert_equal ["ar", "hr"], result
  end

  def test_it_assigns_new_links_when_told
    node.assign_new_link_at_first_letter_of("pizza")
    result = node.link_at_first_letter_of("pizza").links.keys

    assert_equal ["i"], result
  end

  def test_ending_words
    node.end_word(["c", "a", "t"])
    assert_equal "cat", node.word
    assert_equal true, node.terminator
  end


end
