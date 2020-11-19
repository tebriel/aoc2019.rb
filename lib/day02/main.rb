# frozen_string_literal: true

# An Intcode processor
class Intcode
  attr_reader :memory
  attr_reader :halted

  def initialize(memory)
    @halted = false
    @instruction_pointer = 0
    @memory = memory
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
    param1 = get_val(@instruction_pointer + 1)
    param2 = get_val(@instruction_pointer + 2)
    set_val(@instruction_pointer + 3, param1 + param2)
    return 4
  end

  def multiplies
    param1 = get_val(@instruction_pointer + 1)
    param2 = get_val(@instruction_pointer + 2)
    set_val(@instruction_pointer + 3, param1 * param2)
    return 4
  end

  def get_val(address)
    @memory[@memory[address]]
  end

  def set_val(address, val)
    @memory[@memory[address]] = val
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
  # fix the memory
  memory[1] = 12
  memory[2] = 2
  intcode = Intcode.new(memory)
  intcode.start
  puts "Value at 0: #{intcode.memory[0]}"
end
