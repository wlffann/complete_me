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

  def test_word_walks_down_tree
    skip
    node.insert_node("pizza")
    node.insert_node("pp")
    result = node.walk("izzeria")

    assert_equal true, result
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
    
    assert_equal ["ar"], result
  end

  def test_it_finds_link_at_certain_letter
    node.insert_node("pizza")
    result = node.link_at_first_letter_of("izza").links.keys

    assert_equal ["z"], result
  end

  def test_it_assigns_new_links_when_told
    node.assign_new_link_at_first_letter_of("pizza")
    result = node.link_at_first_letter_of("pizza").links.keys

    assert_equal ["i"], result
  end

  def test_ending_words
    node.end_word

    assert_equal true, node.terminator
  end

  def test_a_node_has_links
    # skip
    node.assign_new_link_at_first_letter_of("sam")
    result = node.has_links?

    assert_equal true, result
  end

end
