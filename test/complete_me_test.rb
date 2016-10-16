gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :trie

  def setup
    @trie = Trie.new
  end

  def test_class_exists
    assert trie
  end

  def test_insert_blank_item
    trie.insert("pizza")
    # binding.pry
    assert_equal 1, trie.count
  end

  def test_it_inserts_a_different_word
    trie.insert("cat")
    binding.pry
    assert_equal 1, trie.count
  end

  def test_insert_one_item
    skip
  end

end
