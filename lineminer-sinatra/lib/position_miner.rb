# Find lines in file by looking up there byte offset
class PositionMiner
  @@line_positions = []

  def self.init(file)
    f = File.open(file, 'r')
    i = 0
    until f.eof?
      @@line_positions[i] = f.pos
      i += 1
      f.readline
    end
    f.close
  end

  def self.find_line(index, file)
    f = File.open(file, 'r')
    f.pos = @@line_positions[index - 1]
    result = f.readline.strip
    f.close
    result
  end

  def self.line_positions
    @@line_positions
  end
end
