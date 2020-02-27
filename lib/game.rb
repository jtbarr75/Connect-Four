require_relative 'board.rb'

class Game
  attr_reader :board, :light_turn

  DARK = "\u{263A}"
  LIGHT = "\u{263B}"

  def initialize
    @board = Board.new
    @light_turn = true
  end

  #begins the game loop
  def start
    puts "Connect Four! Try to get four pieces in a row before the other player."
    board.print_grid
    until over?
      board.place_piece( light_turn ? LIGHT : DARK, choose_column )
      board.print_grid
      @light_turn = !@light_turn
    end
  end

  #prompts player to choose from available columns
  def choose_column
    available_cols = board.available_columns
    loop do
      puts "#{@light_turn ? LIGHT : DARK}'s turn."
      puts "Please choose a column from (#{available_cols.join(", ")})"
      col = gets.chomp.to_i
      return col if available_cols.include? col 
    end
  end

  #returns true if the board is full or if a player has four in row horizontally, vertically, or diagonally
  def over?
    winner = @light_turn ? DARK : LIGHT
    if board.win?(winner)
      puts "#{winner} Wins!"
      return true
    elsif board.available_columns.empty?
      puts "Tie game!"
      return true
    end
    false
  end
end