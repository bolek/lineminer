# Find line in file be reading one by one from top
module NaiveMiner
  def self.init
  end

  def self.find_line(index, file)
    f = File.open(file, 'r')
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
