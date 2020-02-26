require_relative 'board.rb'

class Game
  attr_reader :board, :light_turn

  LIGHT = "\u{263A}"
  DARK = "\u{263B}"

  def initialize
    @board = Board.new
    @light_turn = true
  end

  def start
    puts "Connect Four! Try to get four pieces in a row before the other player."
    board.print_grid
    until game_over?
      board.place_piece( light_turn ? LIGHT : DARK, choose_column )
      board.print_grid
    end
  end

  def choose_column
    available_cols = board.available_columns
    loop do
      puts "Please choose a column from (#{available_cols.join(", ")})"
      col = gets.chomp.to_i
      return col if available_cols.include? col 
    end
  end

  def game_over?
    return board.win?(LIGHT)
  end
end