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

  def test_it_can_split_message
    shift = Shift.new
    expected = ["h", "i", ",", " ", "w", "o", "r", "l", "d"]

    assert_equal expected, shift.split_lowercase_message("hI, WoRlD")
  end

  def test_it_can_create_character_set_hash
    shift = Shift.new
    expected = {
      "a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4, "f"=>5, "g"=>6,
      "h"=>7, "i"=>8, "j"=>9, "k"=>10, "l"=>11, "m"=>12, "n"=>13,
      "o"=>14, "p"=>15, "q"=>16, "r"=>17, "s"=>18, "t"=>19, "u"=>20,
      "v"=>21, "w"=>22, "x"=>23, "y"=>24, "z"=>25, " "=>26
    }

    assert_equal expected, shift.character_set_hash
  end

  def test_it_can_encrypt_message
    shift = Shift.new
    shifts = {A: 6, B: 3, C: 1, D: 5}

    shift.stubs(:final_shifts).returns(shifts)
    assert_equal "nhmqucxtxoe", shift.encrypt("Hello World")
    assert_equal "nhmqu,aauumi!", shift.encrypt("Hello, World!")
  end
end
