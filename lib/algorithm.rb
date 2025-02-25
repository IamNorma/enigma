require 'date'

class Algorithm
  attr_reader :date, :character_set

  def initialize
    @date = Date.today.strftime("%d%m%y")
    @character_set = ("a".."z").to_a << " "
  end

  def random_number
    rand(99999).to_s.rjust(5,'0')
  end

  def create_keys(random_number)
    {
      A: random_number[0..1].to_i,
      B: random_number[1..2].to_i,
      C: random_number[2..3].to_i,
      D: random_number[3..4].to_i
    }
  end

  def squared_date(date)
    date.to_i ** 2
  end

  def last_four_digits(date)
    squared = squared_date(date)
    squared.to_s[-4..-1].to_i
  end

  def create_offsets(date)
    four_digits = last_four_digits(date).to_s
    {
      A: four_digits[0].to_i,
      B: four_digits[1].to_i,
      C: four_digits[2].to_i,
      D: four_digits[3].to_i
    }
  end

  def final_shifts(random_number, date)
    keys = create_keys(random_number)
    offsets = create_offsets(date)
    keys.merge(offsets) do |key, key_value, offset_value|
      key_value + offset_value
    end
  end

  def split_lowercase_message(message)
    message.downcase.split("")
  end

  def character_set_hash
    @character_set.map.with_index do |character, index|
      [character, index]
    end.to_h
  end

  def encrypt(message, random_number, date)
    message_to_encrypt = split_lowercase_message(message)
    encrypted = []
    message_to_encrypt.map.with_index do |character, index|
      if @character_set.include?(character) == false
        encrypted << character
      elsif index % 4 == 0
        a_shift = @character_set.rotate(final_shifts(random_number, date)[:A])
        encrypted << a_shift[character_set_hash[character]]
      elsif index % 4 == 1
        b_shift = @character_set.rotate(final_shifts(random_number, date)[:B])
        encrypted << b_shift[character_set_hash[character]]
      elsif index % 4 == 2
        c_shift = @character_set.rotate(final_shifts(random_number, date)[:C])
        encrypted << c_shift[character_set_hash[character]]
      elsif index % 4 == 3
        d_shift = @character_set.rotate(final_shifts(random_number, date)[:D])
        encrypted << d_shift[character_set_hash[character]]
      end
    end
    encrypted.join("")
  end

  def decrypt(message, random_number, date)
    message_to_decrypt = split_lowercase_message(message)
    decrypted = []
    message_to_decrypt.map.with_index do |character, index|
      if @character_set.include?(character) == false
        decrypted << character
      elsif index % 4 == 0
        a_shift = @character_set.rotate(-final_shifts(random_number, date)[:A])
        decrypted << a_shift[character_set_hash[character]]
      elsif index % 4 == 1
        b_shift = @character_set.rotate(-final_shifts(random_number, date)[:B])
        decrypted << b_shift[character_set_hash[character]]
      elsif index % 4 == 2
        c_shift = @character_set.rotate(-final_shifts(random_number, date)[:C])
        decrypted << c_shift[character_set_hash[character]]
      elsif index % 4 == 3
        d_shift = @character_set.rotate(-final_shifts(random_number, date)[:D])
        decrypted << d_shift[character_set_hash[character]]
      end
    end
    decrypted.join("")
  end
end
