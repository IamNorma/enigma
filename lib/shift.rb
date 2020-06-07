class Shift

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
end
