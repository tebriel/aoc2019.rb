#!/usr/bin/env ruby

def calc_fuel(weight)
  [(weight / 3).floor - 2, 0].max
end

if $PROGRAM_NAME == __FILE__
  sum = 0
  File.foreach("input.txt") do |line|
    sum += calc_fuel(line.chomp.to_i)
  end
  puts sum
end
