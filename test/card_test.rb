require 'minitest/autorun'
require 'minitest/pride'
require './lib/card.rb'
require 'pry'

class CardTest < Minitest::Test

  def test_it_exists
    card = Card.new("Ace", "Spades")
    assert_instance_of Card, card
  end

  def test_it_assigns_attributes
    card = Card.new("Ace", "Spades")
    card_1 = Card.new("Ace", "Spades")
    card_2 = Card.new("Ace", "Spades")
    binding.pry
    assert_equal "Ace", card.value
    assert_equal "Spades", card.suit
  end
end
