require 'date'

class Enigma
  attr_reader :algorithm

  def initialize
    @algorithm = Algorithm.new
  end

  def encrypt(message, key = algorithm.random_number, date = algorithm.date)
    {
     encryption: algorithm.encrypt(message, key, date),
     key: key,
     date: date
    }
  end
end
