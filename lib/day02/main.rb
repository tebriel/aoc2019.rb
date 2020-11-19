# frozen_string_literal: true

# An Intcode processor
class Intcode
  attr_reader :memory
  attr_reader :halted

  def initialize(memory)
    @halted = false
    @instruction_pointer = 0
    @memory = memory.dup
    @instructions = {
      1 => method(:adds),
      2 => method(:multiplies),
      99 => method(:halt)
    }.freeze
  end

  def halt
    @halted = true
    return 0
  end

  def adds
    param1 = get_val(get_val(@instruction_pointer + 1))
    param2 = get_val(get_val(@instruction_pointer + 2))
    set_val(get_val(@instruction_pointer + 3), param1 + param2)
    return 4
  end

  def multiplies
    param1 = get_val(get_val(@instruction_pointer + 1))
    param2 = get_val(get_val(@instruction_pointer + 2))
    set_val(get_val(@instruction_pointer + 3), param1 * param2)
    return 4
  end

  def get_val(address)
    @memory[address]
  end

  def set_val(address, val)
    @memory[address] = val
  end

  def start
    loop do
      @instruction_pointer += @instructions[@memory[@instruction_pointer]].call
      break if @halted
    end
  end
end

if $PROGRAM_NAME == __FILE__
  f = File.open('inputs/day02.txt')
  memory = []
  f.read.chomp.split(',').each do |a|
    memory.push(a.to_i)
  end
  f.close
  memory.freeze
  intcode = Intcode.new(memory)
  # fix the memory
  intcode.set_val(1, 12)
  intcode.set_val(2, 2)
  intcode.start
  puts "Part 1 Answer: #{intcode.memory[0]}"

  (0..99).to_a.permutation(2).each do |nouns|
    intcode = Intcode.new(memory)
    intcode.set_val(1, nouns[0])
    intcode.set_val(2, nouns[1])
    intcode.start
    if intcode.memory[0] == 19690720
      puts "Part 2 Answer: #{100 * nouns[0] + nouns[1]}"
      break
    end
  end
end
