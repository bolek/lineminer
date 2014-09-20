# Find lines in file by looking up there byte offset
class PositionMiner

  def initialize(file)
    @file = file
    @line_positions = []

    f = File.open(file, 'r')
    i = 0
    until f.eof?
      @line_positions[i] = f.pos
      i += 1
      f.readline
    end
    f.close
  end

  def find_line(index)
    f = File.open(@file, 'r')
    f.pos = @line_positions[index - 1]
    result = f.readline.strip
    f.close
    result
  end
end
