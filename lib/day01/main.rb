#!/usr/bin/env ruby
# frozen_string_literal: true

def calc_fuel(weight)
  [(weight / 3).floor - 2, 0].max
end

def calc_fuel_for_fuel(fuel_weight)
  sum = 0
  until fuel_weight.zero?
    fuel_weight = calc_fuel(fuel_weight)
    sum += fuel_weight
  end
  sum
end

if $PROGRAM_NAME == __FILE__
  sum = 0
  fuel = 0
  File.foreach('inputs/day01.txt') do |line|
    temp_f = calc_fuel(line.chomp.to_i)
    sum += temp_f
    fuel += calc_fuel_for_fuel(temp_f)
  end
  puts "Fuel for modules #{sum}"
  puts "Fuel for modules + fuel #{sum + fuel}"
end
