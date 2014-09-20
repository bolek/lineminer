class Miner
  def initialize(file)
    @file = file
  end

  class OutOfRange < Exception
    def initialize(msg = 'Line index is out of range')
      super
    end
  end

  private

  def read_file
    File.open(@file, 'r') do |f|
      yield f if block_given?
    end
  end
end
