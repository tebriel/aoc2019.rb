# frozen_string_literal: true

# An Intcode processor
class Intcode
  attr_reader :memory

  def initialize(memory)
    @cur_idx = 0
    @memory = memory
    @opcodes = {
      1 => method(:adds),
      2 => method(:multiplies),
      99 => method(:halt)
    }.freeze
  end

  def halt(_index)
    puts "Value at 0: #{@memory[0]}"
    exit(true)
  end

  def adds(index)
    set_val(index + 3, get_val(index + 1) + get_val(index + 2))
  end

  def multiplies(index)
    set_val(index + 3, get_val(index + 1) * get_val(index + 2))
  end

  def get_val(index)
    @memory[@memory[index]]
  end

  def set_val(index, val)
    @memory[@memory[index]] = val
  end

  def start
    loop do
      @opcodes[@memory[@cur_idx]].call(@cur_idx)
      @cur_idx += 4
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
end
