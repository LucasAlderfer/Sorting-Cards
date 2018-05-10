require 'minitest/autorun'
require 'minitest/pride'
require './lib/guess.rb'
require './lib/card.rb'
require 'pry'
 
class GuessTest < Minitest::Test

  def test_it_exists
    card = Card.new("10", "Hearts")
    guess = Guess.new("10 of Hearts", card)
    assert_instance_of Guess, guess
  end

  def test_it_assigns_values
    card = Card.new("10", "Hearts")
    guess = Guess.new("10 of Hearts", card)
    assert_equal card, guess.card
    assert_equal "10 of Hearts", guess.response
  end

  def test_it_compares_response
    card = Card.new("10", "Hearts")
    guess = Guess.new("10 of Hearts", card)
    assert_equal true, guess.correct?
  end

  def test_it_replies
    card = Card.new("10", "Hearts")
    guess = Guess.new("10 of Hearts", card)
    assert_equal "Correct!", guess.feedback
  end

  def test_it_can_handle_failure
    card = Card.new("Queen", "Clubs")
    guess = Guess.new("2 of Diamonds", card)
    assert_equal card, guess.card
    assert_equal "2 of Diamonds", guess.response
    assert_equal false, guess.correct?
    assert_equal "Incorrect.", guess.feedback
  end

end
