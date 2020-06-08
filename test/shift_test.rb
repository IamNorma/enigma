require './test/test_helper'
require './lib/shift'
require 'mocha/minitest'
require 'pry'

class ShiftTest < Minitest::Test
  def test_it_exists
    shift = Shift.new

    assert_instance_of Shift, shift
  end

  def test_it_has_date
    Date.stubs(:today).returns(Date.new(2020, 06, 06))
    shift = Shift.new

    assert_equal "060620", shift.date
  end

  def test_it_starts_with_character_set
    shift = Shift.new

    assert_equal ("a".."z").to_a << " ", shift.character_set
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

  def test_squared_date
    shift = Shift.new
    shift.stubs(:date).returns("040620")

    assert_equal 1649984400, shift.squared_date
  end

  def test_it_can_get_last_four_digits
    shift = Shift.new
    squared_date = 1649984400
    shift.stubs(:squared_date).returns(squared_date)

    assert_equal 4400, shift.last_four_digits
  end

  def test_it_can_create_offsets
    shift = Shift.new
    number = 4400
    expected = {A: 4, B: 4, C: 0, D: 0}

    shift.expects(:last_four_digits).returns(number)
    assert_equal expected, shift.create_offsets
  end

  def test_it_can_create_final_shifts
    shift = Shift.new
    keys = {A: 02, B: 27, C: 71, D: 15}
    offsets = {A: 4, B: 4, C: 0, D: 0}
    expected = {A: 6, B: 31, C: 71, D: 15}

    shift.expects(:create_offsets).returns(offsets)
    shift.expects(:create_keys).returns(keys)
    assert_equal expected, shift.final_shifts
  end

  def test_it_can_lowercase
    shift = Shift.new

    assert_equal "hello world", shift.lowercase("HEllo WorlD")
    assert_equal "hello, world!", shift.lowercase("HEllo, WorlD!")
  end

  def test_it_can_encrypt_message
    skip
    shift = Shift.new

    assert_equal "lakf alkdj", shift.encrypt("Hello World")
  end
end
