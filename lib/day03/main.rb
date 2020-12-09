# frozen_string_literal: true

require 'set'

def route_calculator(turns)
  current = [0, 0]
  points = [current]
  turns.each do |turn|
    direction = turn[0]
    steps = turn[1..].to_i
    case direction
    when 'R'
      steps.times { |_step| points.append(current = [current[0] + 1, current[1]]) }
    when 'L'
      steps.times { |_step| points.append(current = [current[0] - 1, current[1]]) }
    when 'D'
      steps.times { |_step| points.append(current = [current[0], current[1] - 1]) }
    when 'U'
      steps.times { |_step| points.append(current = [current[0], current[1] + 1]) }
    end
  end
  points
end

if $PROGRAM_NAME == __FILE__
  routes = []
  File.foreach('inputs/day03.txt') do |line|
    routes.append(route_calculator(line.chomp.split(',')))
  end
  intersections = Set.new(routes[0]) & Set.new(routes[1])
  smallest_distance = 10_000_000_000_000_000
  intersections.each do |intersect|
    next if intersect == [0, 0]

    dist = intersect[0].abs + intersect[1].abs
    smallest_distance = dist if dist < smallest_distance
  end
  puts "Smallest Manhattan Distance: #{smallest_distance}"
  smallest_distance = 10_000_000_000_000_000
  intersections.to_a.sort.each do |intersect|
    next if intersect == [0, 0]

    dist = routes[0].index(intersect) + routes[1].index(intersect)
    smallest_distance = dist if dist < smallest_distance
  end
  puts "Smallest Step Distance: #{smallest_distance}"
end
