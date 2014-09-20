# Find line in file be reading one by one from top
class NaiveMiner

  def initialize(file)
    @file = file
  end

  def find_line(index)
    f = File.open(@file, 'r')
    response = ''
    index.times do
      if f.eof?
        f.close
        fail EOFError
      end
      response =  f.readline.to_s
    end
    f.close
    response.strip
  end
end
