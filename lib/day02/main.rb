# frozen_string_literal: true

# An Intcode processor
class Intcode
  attr_reader :program

  def initialize(program)
    @cur_idx = 0
    @program = program
    @opcodes = {
      1 => method(:adds),
      2 => method(:multiplies),
      99 => method(:halt)
    }.freeze
  end

  def halt(_index)
    puts "Value at 0: #{@program[0]}"
    exit(true)
  end

  def adds(index)
    set_val(index + 3, get_val(index + 1) + get_val(index + 2))
  end

  def multiplies(index)
    set_val(index + 3, get_val(index + 1) * get_val(index + 2))
  end

  def get_val(index)
    @program[@program[index]]
  end

  def set_val(index, val)
    @program[@program[index]] = val
  end

  def start
    loop do
      @opcodes[@program[@cur_idx]].call(@cur_idx)
      @cur_idx += 4
    end
  end
end

if $PROGRAM_NAME == __FILE__
  f = File.open('inputs/day02.txt')
  program = []
  f.read.chomp.split(',').each do |a|
    program.push(a.to_i)
  end
  f.close
  # fix the program
  program[1] = 12
  program[2] = 2
  intcode = Intcode.new(program)
  intcode.start
end
