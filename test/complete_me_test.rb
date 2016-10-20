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

  def test_it_counts_numbers_of_words
    skip
    trie.populate('./test/words_1')
    result = trie.count

    assert_equal 5, result
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

  def test_pull_first_letter_word_method
    skip
    result = trie.pull_first_letter("pizza")

    assert_equal "p", result
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
    trie.populate("./test/words_1")
    # binding.pry
    assert_equal ["a", "b"], trie.base_node.links.keys
  end

  #testing node behavior through trie

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
    # binding.pry
    assert_equal ["a"], result
  end

   def test_it_can_walk_into_correct_node
     skip
    trie.insert("aa")
    trie.insert("aardvark")
    trie.insert("any")
    trie.insert("animal")
    result = trie.base_node.links["a"].links.keys
    # binding.pry
    assert_equal ["a", "n"], result
  end

  def test_suggested_stem_is_not_word
    skip
    trie.insert("be")
    result = trie.suggest("b")
    assert_equal ["be"], result
  end

  def test_it_returns_words_with_suggest
    skip
    trie.populate("./test/words")

    result = trie.suggest("be")

    assert_equal ["be", "bear", "beer", "begin"], result.sort
  end

  def test_suggest_works_on_double_first_letter
    skip
    trie.insert("aardvark")
    result = trie.suggest("a")
    assert_equal ["aardvark"], result
  end

end
