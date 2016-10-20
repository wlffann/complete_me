require 'simplecov'
SimpleCov. start do
  add_filter 'test'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :trie

  def setup
    @trie = CompleteMe.new
  end

  def test_class_exists
    assert trie
  end

  def test_insert_word
    trie.insert("pizza")

    assert_equal 1, trie.count
    assert_equal ["p"], trie.base_node.links.keys
  end

  def test_it_inserts_two_different_words_begining_different_letter
    trie.insert("catty")
    trie.insert("pizza")

    assert_equal 2, trie.count
    assert_equal ["c", "p"], trie.base_node.links.keys
  end

  def test_it_inserts_three_different_words_begining_different_letter
    trie.insert("catty")
    trie.insert("pizza")
    trie.insert("horse")

    assert_equal 3, trie.count
    assert_equal ["c", "p", "h"], trie.base_node.links.keys
  end

  def test_insert_a_second_item
    trie.insert("pizza")
    trie.insert("pizzeria")

    assert_equal 2, trie.count
    assert_equal ["p"], trie.base_node.links.keys
  end

  def test_it_counts_numbers_of_word
    trie.populate("pizza\ncat\ndog")
    result = trie.count

    assert_equal 3, result
  end

  def test_base_node_begins_with_no_links
    refute trie.base_node.has_links?
  end

  def test_node_has_links
    trie.insert("pizza")

    assert trie.base_node.has_links?
  end
  
  def test_read_file_method
    result = trie.read_file('words_1')
    assert_equal ["aa", "aardvark", "animal", "antique", "bear"], result
  end

  def test_it_populates_multiple_words
    trie.populate_from_file("words_1")
    
    assert_equal ["a", "b"], trie.base_node.links.keys
  end

  def test_it_can_walk_even_with_double_letters
    trie.insert("bear")
    trie.insert("beer")
    trie.insert("bee")
    result = trie.base_node.links["b"].links["e"].links.keys

    assert_equal ["a", "e"], result
  end

  def test_it_can_insert_if_word_begins_with_double_letter
    trie.insert("aa")
    result = trie.base_node.links.keys

    assert_equal ["a"], result
  end

  def test_it_can_walk_if_two_words_begin_with_double_letters
    trie.insert("aa")
    trie.insert("aardvark")
    result = trie.base_node.links["a"].links.keys
    
    assert_equal ["a"], result
  end

   def test_it_can_walk_into_correct_node
    trie.insert("aa")
    trie.insert("aardvark")
    trie.insert("any")
    trie.insert("animal")
    result = trie.base_node.links["a"].links.keys
    
    assert_equal ["a", "n"], result
  end

  def test_suggested_stem_is_not_word
    trie.insert("be")
    result = trie.suggest("b")

    assert_equal ["be"], result
  end

  def test_insert_is_correct
    trie.insert("be")
    trie.insert("any")
    trie.insert("beer")
    trie.insert("bear")

    result = trie.base_node.links.keys
    assert_equal ["b", "a"], result
  end

  def test_it_returns_words_with_suggest
    # trie.populate(File.read('./test/words'))
    trie.populate("aa\naardvark\nanimal\nantique\nbear\npizza\npizzeria\ntrunk\nfabulous\nutensil\npizzaz\nannie\nante\nant\npizzle\nbeer\nbegin\nbe")
    result = trie.suggest("be")

    assert_equal ["be", "bear", "beer", "begin"], result.sort
  end

  def test_suggest_works_on_double_first_letter
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
   trie.insert("pizza")
   trie.insert("pizzeria")
   trie.insert("pizzicato")
   trie.select("piz", "pizzeria")
   trie.select("piz", "pizzeria")
   result = trie.selection_dictionary["piz"][0][1]

   assert_equal 2, result
 end

 def test_it_can_add_selection_when_stem_is_already_there
  trie.insert("pizza")
  trie.insert("pizzeria")
  trie.insert("pizzicato")
  trie.select("piz", "pizzeria")
  trie.select("piz", "pizzicato")
  result = trie.selection_dictionary["piz"]

  assert_equal [["pizzeria", 1], ["pizzicato", 1]], result
 end

 def test_it_puts_selection_first_when_suggesting
  trie.insert("pizzeria")
  trie.insert("pizzaz")
  trie.select("piz", "pizzeria")
  result = trie.suggest("piz")
  
  assert_equal ["pizzeria", "pizzaz"], result
 end

  def test_it_can_add_multiple_selections_to_selection_dictionary
    trie.insert("pizza")
    trie.insert("pizzeria")
    trie.select("piz", "pizzeria")
    trie.select("pi", "pizza")
    result = trie.selection_dictionary

    assert_equal ({"piz" => [["pizzeria", 1]], "pi" => [["pizza", 1]]}), result
  end

  def test_it_adds_to_counter_when_selection_is_called_again
    trie.insert("pizza")
    trie.insert("pizzeria")
    trie.insert("pizzicato")
    trie.select("piz", "pizzeria")
    trie.select("piz", "pizzeria")
    result = trie.selection_dictionary["piz"][0][1]

    assert_equal 2, result
  end

  def test_it_can_add_selection_when_stem_is_already_there
    trie.insert("pizza")
    trie.insert("pizzeria")
    trie.insert("pizzicato")
    trie.select("piz", "pizzeria")
    trie.select("piz", "pizzicato")
    result = trie.selection_dictionary["piz"]

    assert_equal [["pizzeria", 1], ["pizzicato", 1]], result
  end

  def test_it_puts_selection_first_when_suggesting
    trie.insert("piano")
    trie.insert("pizzeria")
    trie.insert("pizzaz")
    trie.insert("pizzicato")
    trie.select("piz", "pizzeria")
    result = trie.suggest("piz")

    assert_equal ["pizzeria",  "pizzaz", "pizzicato"], result
  end

end
