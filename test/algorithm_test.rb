require './test/test_helper'
require './lib/algorithm'

class AlgorithmTest < Minitest::Test
  def test_it_exists
    algorithm = Algorithm.new

    assert_instance_of Algorithm, algorithm
  end

  def test_it_has_date
    Date.stubs(:today).returns(Date.new(2020, 06, 06))
    algorithm = Algorithm.new

    assert_equal "060620", algorithm.date
  end

  def test_it_starts_with_character_set
    algorithm = Algorithm.new

    assert_equal ("a".."z").to_a << " ", algorithm.character_set
  end

  def test_it_can_create_random_digits
    algorithm = Algorithm.new

    algorithm.stubs(:rand).returns("02715")
    assert_equal "02715", algorithm.random_number
  end

  def test_it_can_create_keys
    algorithm = Algorithm.new
    # number = "02715"
     expected = {A: 02, B: 27, C: 71, D: 15}
    #
    # algorithm.expects(:create_random_number).returns(number)
    assert_equal expected, algorithm.create_keys("02715")
  end

  def test_squared_date
    algorithm = Algorithm.new
    # algorithm.stubs(:date).returns("040620")

    assert_equal 1672401025, algorithm.squared_date("040895")
  end

  def test_it_can_get_last_four_digits
    algorithm = Algorithm.new
    # squared_date = 1649984400
    # algorithm.stubs(:squared_date).returns(squared_date)

    assert_equal 1025, algorithm.last_four_digits("040895")
  end

  def test_it_can_create_offsets
    algorithm = Algorithm.new
    # number = 4400
    expected = {A: 1, B: 0, C: 2, D: 5}

    # algorithm.expects(:last_four_digits).returns(number)
    assert_equal expected, algorithm.create_offsets("040895")
  end

  def test_it_can_create_final_shifts
    algorithm = Algorithm.new
    # keys = {A: 02, B: 27, C: 71, D: 15}
    # offsets = {A: 4, B: 4, C: 0, D: 0}
    expected = {:A=>3, :B=>27, :C=>73, :D=>20}

    # algorithm.expects(:create_offsets).returns(offsets)
    # algorithm.expects(:create_keys).returns(keys)
    assert_equal expected, algorithm.final_shifts("02715", "040895")
  end

  def test_it_can_split_message
    algorithm = Algorithm.new
    expected = ["h", "i", ",", " ", "w", "o", "r", "l", "d"]

    assert_equal expected, algorithm.split_lowercase_message("hI, WoRlD")
  end

  def test_it_can_create_character_set_hash
    algorithm = Algorithm.new
    expected = {
      "a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4, "f"=>5, "g"=>6,
      "h"=>7, "i"=>8, "j"=>9, "k"=>10, "l"=>11, "m"=>12, "n"=>13,
      "o"=>14, "p"=>15, "q"=>16, "r"=>17, "s"=>18, "t"=>19, "u"=>20,
      "v"=>21, "w"=>22, "x"=>23, "y"=>24, "z"=>25, " "=>26
    }

    assert_equal expected, algorithm.character_set_hash
  end

  def test_it_can_encrypt_message
    algorithm = Algorithm.new
    # shifts = {A: 6, B: 3, C: 1, D: 5}
    #
    # algorithm.stubs(:final_shifts).returns(shifts)
    assert_equal "keder ohulw", algorithm.encrypt("Hello World", "02715", "040895")
    assert_equal "keder,sprrdx!", algorithm.encrypt("Hello, World!", "02715", "040895")
  end

  def test_it_can_decrypt_message
    algorithm = Algorithm.new
    # shifts = {A: 6, B: 3, C: 1, D: 5}
    #
    # algorithm.stubs(:final_shifts).returns(shifts)
    assert_equal "hello world", algorithm.decrypt("keder ohulw", "02715", "040895")
    assert_equal "hello, world!", algorithm.decrypt("keder,sprrdx!", "02715", "040895")
  end
end
