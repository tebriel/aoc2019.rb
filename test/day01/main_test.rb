# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day01/main'

describe '#calc_fuel' do
  it 'runs some common cases' do
    assert_equal(0, calc_fuel(0))
    assert_equal(2, calc_fuel(12))
    assert_equal(2, calc_fuel(14))
    assert_equal(654, calc_fuel(1969))
    assert_equal(33_583, calc_fuel(100_756))
  end
end

describe '#calc_fuel_for_fuel' do
  it 'runs some common cases' do
    fuel = calc_fuel(14)
    assert_equal(2, fuel + calc_fuel_for_fuel(fuel))
    fuel = calc_fuel(1969)
    assert_equal(966, fuel + calc_fuel_for_fuel(fuel))
    fuel = calc_fuel(100_756)
    assert_equal(50_346, fuel + calc_fuel_for_fuel(fuel))
  end
end
