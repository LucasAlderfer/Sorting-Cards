require './lib/card.rb'
require './lib/deck.rb'
require './lib/guess.rb'
require 'pry'
 
class Round
  attr_reader :deck,
              :guesses,
              :number_correct

  def initialize(deck)
    @deck = deck
    @guesses = []
    @number_correct = 0
  end

  def current_card
    @deck.cards.first
  end

  def record_guess(card)
    try = card
    compare_card = @deck.cards.first
    @guess = Guess.new(try, compare_card)
    @deck.cards.shift
    @deck.cards << compare_card
    @guesses << @guess
    if @guess.correct? == true
      @number_correct += 1
    end
    @guess
  end

  def count
    @guesses.length
  end

  def percent_correct
    (@number_correct.to_f / @guesses.length) * 100
  end

end
