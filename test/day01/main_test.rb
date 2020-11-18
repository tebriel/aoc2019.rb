require "minitest/autorun"
require "day01/main"

describe "#calc_fuel" do
  it "runs some common cases" do
    assert_equal(0, calc_fuel(0))
    assert_equal(2, calc_fuel(12))
    assert_equal(2, calc_fuel(14))
    assert_equal(654, calc_fuel(1969))
    assert_equal(33583, calc_fuel(100756))
  end
end
