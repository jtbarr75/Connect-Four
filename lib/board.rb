class Board
  attr_reader :grid

  BLANK = "\u{25EF}"
  LIGHT = "\u{263A}"
  DARK = "\u{263B}"

  def initialize
    @grid = create_grid
  end

  #create a 6x7 grid of blank circles
  def create_grid
    grid = []
    6.times do |row|
      grid << []
      7.times do
        grid[row] << BLANK
      end
    end
    grid
  end

  #prints the grid
  def print_grid
    grid.each do |row|
      puts row.join(" ")
    end
  end

  #places given piece to the lowest unoccupied spot in the grid
  def place_piece(piece, col)
    #transpose the grid so sub arrays are now columns instead of rows
    t = grid.transpose 
    #start at end of column subarray and place piece in first blank spot
    t[col].length.downto(0) do |row|
      if t[col][row] == BLANK
        t[col][row] = piece
        break
      end
    end
    @grid = t.transpose
  end
end