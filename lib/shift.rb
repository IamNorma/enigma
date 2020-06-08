require 'date'

class Shift
  attr_reader :date, :character_set

  def initialize
    @date = Date.today.strftime("%d%m%y")
    @character_set = ("a".."z").to_a << " "
  end

  def create_random_number
    rand(99999).to_s.rjust(5,'0')
  end

  def create_keys
    random_number = create_random_number
    {
      A: random_number[0..1].to_i,
      B: random_number[1..2].to_i,
      C: random_number[2..3].to_i,
      D: random_number[3..4].to_i
    }
  end

  def squared_date
    date.to_i ** 2
  end

  def last_four_digits
    squared = squared_date
    squared.to_s[-4..-1].to_i
  end

  def create_offsets
    four_digits = last_four_digits.to_s
    {
      A: four_digits[0].to_i,
      B: four_digits[1].to_i,
      C: four_digits[2].to_i,
      D: four_digits[3].to_i
    }
  end

  def final_shifts
    keys = create_keys
    offsets = create_offsets
    keys.merge(offsets) do |key, key_value, offset_value|
      key_value + offset_value
    end
  end

  def encrypt(message)
    new = message.downcase
    new.split("")
  end
end
