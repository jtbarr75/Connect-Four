class Board
  attr_reader :grid

  BLANK = "\u{25EF}"
  LIGHT = "\u{263A}"
  DARK = "\u{263B}"

  def initialize
    @grid = create_grid
  end

  #Create a 6x7 grid of blank circles
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

  #Prints the grid
  def print_grid
    grid.each do |row|
      puts row.join(" ")
    end
  end

  #Places given piece to the lowest unoccupied spot in the grid
  def place_piece(piece, col)
    #Transpose the grid so sub arrays are now columns instead of rows
    t = grid.transpose 
    #Start at end of column subarray and place piece in first blank spot
    t[col].length.downto(0) do |row|
      if t[col][row] == BLANK
        t[col][row] = piece
        break
      end
    end
    @grid = t.transpose
  end

  #Returns indexes of columns with one or more blank spaces
  def available_columns
    available_cols = []
    #Transpose the grid so sub arrays are now columns instead of rows
    t = grid.transpose
    t.each_with_index do |col, index|
     available_cols << index if col.any? {|cell| cell == BLANK }
    end
    available_cols
  end
end