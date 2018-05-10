require './lib/guess.rb'
require 'pry'

class Deck
  attr_reader :cards

  def initialize(array)
    @cards = array
  end

  def count
    @cards.length
  end

  def sort
    indices = []
    @cards.each_with_index do |each, index|
      iteration = 0
      bigger_than = 0
      until iteration == @cards.length
        if each.value > @cards[iteration].value
          bigger_than += 1
        end
        iteration += 1
      end
      indices << bigger_than
    end
    hash = Hash.new(0)
    @cards.each_with_index do |each, index|
      hash[each] = index
    end
    sorted_hash = {}
    match = 0
    hash.each do |key, value|
      if value == match
        value = indices[match]
      end
      match += 1
      sorted_hash[key] = value
    end
    inserted = 0
    sorted_array = []
    until inserted == @cards.length
      sorted_hash.each do |key, value|
        if value == inserted
          sorted_array << key
        end
      end
      inserted += 1
    end
    sorted_array
  end

  def split(array)
    first_half = []
    second_half = []
    until array.length == 0
      if array.length % 2 == 0
        first_half << array.shift
      else
        second_half << array.shift
      end
    end
    [first_half, second_half]
  end

  def base_count
    if @cards.length % 2 == 0
      (@cards.length) / 2
    else
      ((@cards.length) / 2) + 1
    end
  end

  def need_to_split?(array)
    if array.length > 2
      true
    else
      false
    end
  end

  def merge(x, y)
    sorted = []
    all_elements = x.length + y.length
    until sorted.length == all_elements
      if (x.length + y.length) == 1
        if x.length == 1
          element = x.shift
          sorted << element
        else
          element = y.shift
          sorted << element
        end
      elsif x.length == 0
        if y[0].value.to_i < y[1].value.to_i
          element = y.shift
          sorted << element
        else
          element = y.pop
          sorted << element
        end
      elsif x[0].value.to_i < y[0].value.to_i
        element = x.shift
        sorted << element
      elsif x[-1].value.to_i < y[0].value.to_i
        element = x.pop
        sorted << element
      else
        element = y.shift
        sorted << element
      end
    end
    sorted
  end

  def coupling(array)
    first_level = array
    next_level = []
    until first_level.length < 2
      couple = []
      couple << first_level.shift
      couple << first_level.shift
      next_level << merge(couple[0], couple[1])
    end
    if first_level.length == 1
      next_level << first_level.shift
    end
    next_level
  end


  def merge_sort
    base_array = []
    base_array << @cards
    new_array_count = base_count
    loop do
      new_base = []
      base_array.each do |each|
        if need_to_split?(each)
          new_arrays = split(each)
          new_arrays.each do |each|
            new_base << each
          end
        else
          new_base << each
        end
      end
      base_array = new_base
      if base_array.length == new_array_count
        break
      end
    end
    base_array.each do |each|
      if each.length != 1
        if each[0].value.to_i > each[1].value.to_i
          each.rotate!
        end
      end
    end
    combines = Math::log(new_array_count, 2).to_i + 1
    combines.times do
      base_array = coupling(base_array)
    end
    base_array[0]
  end

end
