require './lib/card.rb'
require 'pry'
 
class Guess
  attr_reader :card,
              :response

  def initialize(response, card)
    @card = card
    @response = response
  end

  def correct?
    value = @response.split[0]
    suit = @response.split[2]
    if value == @card.value && suit == @card.suit
      true
    else
      false
    end
  end

  def feedback
    value = @response.split[0]
    suit = @response.split[2]
    if value == @card.value && suit == @card.suit
      "Correct!"
    else
      "Incorrect."
    end
  end
end
