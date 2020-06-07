class Shift

  def create_five_digit_number
    rand(99999).to_s.rjust(5,'0')
  end
end
