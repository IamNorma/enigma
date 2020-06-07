require './test/test_helper'
require './lib/shift'
require 'mocha/minitest'
require 'pry'

class ShiftTest < Minitest::Test
  def test_it_exists
    shift = Shift.new

    assert_instance_of Shift, shift
  end

  def test_it_can_create_random_digits
    shift = Shift.new

    shift.stubs(:rand).returns("02715")
    assert_equal "02715", shift.create_five_digit_number
  end
end
