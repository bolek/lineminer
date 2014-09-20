require_relative 'miner'
# Find lines in file by looking up their byte offset
class PositionMiner < Miner
  def initialize(file)
    super

    @line_positions = []
    @line_positions[0] = 0

    read_file do |f|
      f.each_line { @line_positions[f.lineno] = f.pos }
    end
  end

  def find_line(index)
    fail OutOfRange if index > @line_positions.size - 1
    read_file do |f|
      f.pos = @line_positions[index - 1]
      f.readline.strip
    end
  end
end
