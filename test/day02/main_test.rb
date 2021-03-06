# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/day02/main'

describe 'Intcode' do
  describe '#adds' do
    it 'adds two numbers and stores the result' do
      intcode = Intcode.new([1, 0, 0, 0, 99])
      intcode.adds
      expected = [2, 0, 0, 0, 99]
      assert_equal(expected, intcode.memory)
    end
  end

  describe '#multiplies' do
    it 'multiplies two numbers and stores the result' do
      intcode = Intcode.new([2, 3, 0, 3, 99])
      intcode.multiplies
      expected = [2, 3, 0, 6, 99]
      assert_equal(expected, intcode.memory)
    end

    it 'multiplies two other numbers and stores the result' do
      intcode = Intcode.new([2, 4, 4, 5, 99])
      intcode.multiplies
      expected = [2, 4, 4, 5, 99, 9801]
      assert_equal(expected, intcode.memory)
    end
  end
end
