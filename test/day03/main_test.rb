# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day03/main'

describe 'Day03' do
  it 'turns right' do
    result = route_calculator(['R10'])
    assert_equal 11, result.count
    assert result.include?([0, 0])
    assert result.include?([10, 0])
  end
  it 'turns left' do
    result = route_calculator(['L10'])
    assert_equal 11, result.count
    assert result.include?([0, 0])
    assert result.include?([-10, 0])
  end
  it 'turns down' do
    result = route_calculator(['D10'])
    assert_equal 11, result.count
    assert result.include?([0, 0])
    assert result.include?([0, -10])
  end
  it 'turns up' do
    result = route_calculator(['U10'])
    assert_equal 11, result.count
    assert result.include?([0, 0])
    assert result.include?([0, 10])
  end
end
