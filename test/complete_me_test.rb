require 'simplecov'
SimpleCov. start do
  add_filter 'test'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :trie

  def setup
    @trie = Trie.new
  end

  def test_class_exists
    assert trie
  end

  def test_insert_word
    skip
    trie.insert("pizza")

    assert_equal 1, trie.count
    assert_equal ["p"], trie.base_node.links.keys
  end

  def test_it_inserts_two_different_words_begining_different_letter
    skip
    trie.insert("catty")
    trie.insert("pizza")

    assert_equal 2, trie.count
    assert_equal ["c", "p"], trie.base_node.links.keys
  end

  def test_it_inserts_three_different_words_begining_different_letter
    skip
    trie.insert("catty")
    trie.insert("pizza")
    trie.insert("horse")

    assert_equal 3, trie.count
    assert_equal ["c", "p", "h"], trie.base_node.links.keys
  end

  def test_insert_a_second_item
    skip
    trie.insert("pizza")
    trie.insert("pizzeria")

    assert_equal 2, trie.count
    assert_equal ["p"], trie.base_node.links.keys
  end

  def test_it_counts_numbers_of_words
    skip

    trie.populate("pizza\ncat\ndog")
    result = trie.count

    assert_equal 3, result
  end

  def test_base_node_begins_with_no_links
    skip
    refute trie.base_node.has_links?
  end

  def test_node_has_links
    skip
    trie.insert("pizza")

    assert trie.base_node.has_links?
  end

  def test_can_create_node_with_appropriate_letter_link
    skip
    trie.create_node_at_letter_link("pizza")

    assert_equal ["p"], trie.base_node.links.keys
  end

  def test_nodes_link_to_base_calls_nodes_link_to_base
    skip
    trie.insert("pizza")
    result = trie.nodes_link_to_base.first

    assert_equal  ["i"], result.links.keys
  end

  def test_read_file_method
    skip
    result = trie.read_file('./test/words_1')
    assert_equal ["aa", "aardvark", "animal", "antique", "bear"], result
  end

  def test_it_populates_multiple_words
    skip
    trie.populate_from_file("./test/words_1")
    
    assert_equal ["a", "b"], trie.base_node.links.keys
  end

  def test_it_can_walk_even_with_double_letters
    skip
    trie.insert("bear")
    trie.insert("beer")
    trie.insert("bee")
    result = trie.base_node.links["b"].links["e"].links.keys

    assert_equal ["a", "e"], result
  end

  def test_it_can_insert_if_word_begins_with_double_letter
    skip
    trie.insert("aa")
    result = trie.base_node.links.keys

    assert_equal ["a"], result
  end

  def test_it_can_walk_if_two_words_begin_with_double_letters
    skip
    trie.insert("aa")
    trie.insert("aardvark")
    result = trie.base_node.links["a"].links.keys
    
    assert_equal ["a"], result
  end

   def test_it_can_walk_into_correct_node
    skip
    trie.insert("aa")
    trie.insert("aardvark")
    trie.insert("any")
    trie.insert("animal")
    result = trie.base_node.links["a"].links.keys
    
    assert_equal ["a", "n"], result
  end

  def test_suggested_stem_is_not_word
    # skip
    trie.insert("be")
    result = trie.suggest("b")

    assert_equal ["be"], result
  end

  def test_insert_is_correct
    skip
    trie.insert("be")
    trie.insert("any")
    trie.insert("beer")
    trie.insert("bear")

    result = trie.base_node.links.keys
    assert_equal ["b", "a"], result
  end

  def test_it_returns_words_with_suggest
    skip
    trie.populate("aa\naardvark\nanimal\nantique\nbear\npizza\npizzeria\ntrunk\nfabulous\nutensil\npizzaz\nannie\nante\nant\npizzle\nbeer\nbegin\nbe")
    result = trie.suggest("be")

    assert_equal ["be", "bear", "beer", "begin"], result.sort
  end

  def test_suggest_works_on_double_first_letter
    # skip
    trie.insert("aardvark")
    result = trie.suggest("a")
    assert_equal ["aardvark"], result
  end

  def test_it_can_add_selection_to_selection_dictionary

   trie.insert("pizza")
   trie.insert("pizzeria")
   trie.select("piz", "pizzeria")
   result = trie.selection_dictionary

   assert_equal ({"piz" => [["pizzeria", 1]]}), result
 end

 def test_it_adds_to_counter_when_selection_is_called_again
   skip
   trie.insert("pizza")
   trie.insert("pizzeria")
   trie.insert("pizzicato")
   trie.select("piz", "pizzeria")
   trie.select("piz", "pizzeria")
   result = trie.selection_dictionary["piz"][0][1]

   assert_equal 2, result
 end

 def test_it_can_add_selection_when_stem_is_already_there
  # skip
  trie.insert("pizza")
  trie.insert("pizzeria")
  trie.insert("pizzicato")
  trie.select("piz", "pizzeria")
  trie.select("piz", "pizzicato")
  result = trie.selection_dictionary["piz"]

  assert_equal [["pizzeria", 1], ["pizzicato", 1]], result
 end

 def test_it_puts_selection_first_when_suggesting
  trie.insert("pizza")
  trie.insert("pizzeria")
  trie.insert("pizzaz")
  trie.select("piz", "pizzeria")
  result = trie.suggest("piz")
  
  assert_equal ["pizzeria", "pizza", "pizzaz"], result
 end

end
