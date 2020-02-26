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
      7.times { grid[row] << BLANK }
    end
    grid
  end

  #Prints the grid
  def print_grid
    grid.each { |row| puts row.join(" ") }
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

  def win?(piece)
    grid.each do |row|
      row.each_cons(4).each do |combination|
        return true if combination.all? { |a| a == piece }
      end
    end
    grid.transpose.each do |col|
      col.each_cons(4).each do |combination|
        return true if combination.all? { |a| a == piece }
      end
    end
    padding = [*0..(grid.length - 1)].map { |i| [nil] * i }
    padded1 = padding.reverse.zip(grid).zip(padding).map(&:flatten)
    padded2 = padding.zip(grid).zip(padding.reverse).map(&:flatten)
    diagonals_up = padded1.transpose.map(&:compact)
    diagonals_down = padded2.transpose.map(&:compact)
    diagonals = diagonals_up + diagonals_down
    diagonals.each do |diag|
      diag.each_cons(4).each do |combination|
        return true if combination.all? { |a| a == piece }
      end
    end
    false
  end
end