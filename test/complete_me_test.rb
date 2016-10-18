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

  def test_insert_blank_item
    skip
    trie.insert("pizza")
    #  binding.pry
    assert_equal 1, trie.count
    assert_equal ["p"], trie.base_node.links.keys
  end

  def test_it_inserts_a_different_word
    skip
    trie.insert("cat")
    # binding.pry
    assert_equal 1, trie.count
    assert_equal ["c"], trie.base_node.links.keys
  end

  def test_it_inserts_a_second_time_without_losing_first_word
    skip
    trie.insert("catty")
    trie.insert("cat")

    assert_equal 2, trie.count
    assert_equal ["c"], trie.base_node.links.keys
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

  def test_it_knows_my_name
    skip
    trie.insert("ann")
    trie.insert("annie")
    # binding.pry
    assert_equal 2, trie.count
    assert_equal ["a"], trie.base_node.links.keys
  end

  def test_read_file_method
    skip
    result = trie.read_file('./test/words_1')
    assert_equal ["aa", "aardvark", "animal", "antique", "bear"], result
  end

  def test_it_populates_multiple_words
    # skip
    trie.populate("./test/words_1")
    binding.pry
    assert_equal ["a", "b"], trie.base_node.links.keys
  end

  def test_it_can_walk_even_with_double_letters
    trie.insert("bear")
    trie.insert("beer")
    trie.insert("bee")
    
    result = trie.base_node.links["b"].links["e"].links.keys

    assert_equal ["a", "e"], result

  end

  def test_it_returns_words_with_suggest
    skip
    trie.populate("./test/words")
    result = trie.suggest("be")
    assert_equal ["be", "begin", "bear", "beer"], result
  end

end
