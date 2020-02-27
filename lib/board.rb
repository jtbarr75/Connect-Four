class Board
  attr_reader :grid

  BLANK = "\u{25EF}"
  DARK = "\u{263A}"
  LIGHT = "\u{263B}"

  def initialize
    @grid = create_grid
  end

  #Create a 6x7 grid of blank circles
  def create_grid
    grid = Array.new(6, Array.new(7, BLANK))
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

  #check rows and check rows with the grid transposed to check columns
  def win?(piece)
    check_rows(piece, grid) || check_rows(piece, grid.transpose) || check_diagonals(piece)
  end

  #check each row for four consecutive pieces
  def check_rows(piece, arr)
    arr.each do |row|
      row.each_cons(4).each do |combination|
        return true if combination.all? { |a| a == piece }
      end
    end
    false
  end

  #create array of diagonals as subarrays then check for four consecutive pieces
  def check_diagonals(piece)
    #create padding array e.g. [[],[nil],[nil,nil]] etc
    padding = [*0..(grid.length - 1)].map { |i| [nil] * i }

    #pad the grid on both sides to shift each row over i elements
    padded1 = padding.reverse.zip(grid).zip(padding).map(&:flatten)
    diagonals_up = padded1.transpose.map(&:compact)

    #pad the opposite direction to get diagonals the other way
    padded2 = padding.zip(grid).zip(padding.reverse).map(&:flatten)
    diagonals_down = padded2.transpose.map(&:compact)

    #combine all the diagonals
    diagonals = diagonals_up + diagonals_down

    #check diagonals for groups of four
    diagonals.each do |diag|
      diag.each_cons(4).each do |combination|
        return true if combination.all? { |a| a == piece }
      end
    end
    false
  end
end