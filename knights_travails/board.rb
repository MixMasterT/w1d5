class  Board
  attr_reader :size
  attr_accessor :grid

  def initialize(size = 8)
    @grid = Array.new(size) { Array.new(size) { "[ ]" }}
    @size = size
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = "[#{val}]"
  end

  def render
    puts "    #{("A".."H").to_a.join("    ") }\n\n"
    grid.each_with_index do |row, idx|
      puts "#{idx}  #{row.join("  ")}\n\n"
    end

  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b[[4,4]] = 1
  p b
  b.render
end
