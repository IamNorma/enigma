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
    assert_equal "02715", shift.create_random_number
  end

  def test_it_can_create_keys
    shift = Shift.new
    number = "02715"
    expected = {A: 02, B: 27, C: 71, D: 15}

    shift.expects(:create_random_number).returns(number)
    assert_equal expected, shift.create_keys
  end
end
