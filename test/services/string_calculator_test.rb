require 'test_helper'
require_relative '../../app/services/string_calculator'

class StringCalculatorTest < ActiveSupport::TestCase
  def setup
    @calculator = StringCalculator.new
  end

  test "returns 0 for an empty string" do
    assert_equal 0, @calculator.add("")
  end

  test "returns the number itself for a single number" do
    assert_equal 18, @calculator.add("18")
  end

  test "returns the sum of two numbers" do
    assert_equal 43, @calculator.add("1,42")
  end

  test "returns the sum of multiple numbers" do
    assert_equal 16, @calculator.add("1,2,13")
  end

  test "handles new lines and semicolons between numbers" do
    assert_equal 6, @calculator.add("1\n2,3")
    assert_equal 6, @calculator.add("1;2,3")
    assert_equal 3, @calculator.add("//;\n1;2")
  end

  test "raises an exception for negative numbers" do
    exception = assert_raises RuntimeError do
      @calculator.add("1,-2,3")
    end
    assert_equal "Negatives not allowed: -2", exception.message
  end
end
