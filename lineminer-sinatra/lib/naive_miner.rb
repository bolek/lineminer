require_relative 'miner'
# Find line in file be reading one by one from top
class NaiveMiner < Miner
  def find_line(index)
    read_file do |f|
      enumerator = f.each_line
      (index - 1).times { enumerator.next }
      enumerator.next.strip
    end
  rescue StopIteration
    raise OutOfRange
  end
end
