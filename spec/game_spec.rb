require './lib/game'

describe Game do
  DARK ||= "\u{263A}"
  LIGHT ||= "\u{263B}"

  before do
    allow($stdout).to receive(:write)
    @game = Game.new
  end

  describe "#choose_column" do
    it "returns the column the player chooses" do
      allow(@game).to receive(:gets).and_return("0")
      expect(@game.choose_column).to eq(0)
    end

    it "prints the list of available choices" do
      allow(@game).to receive(:gets).and_return("0")
      expect { @game.choose_column }.to output(
        "☻'s turn.\nPlease choose a column from (0, 1, 2, 3, 4, 5, 6)\n"
      ).to_stdout
    end
  end 

  describe "#over?" do
    it "returns true when board.win? returns true" do
      4.times { |col| @game.board.place_piece(DARK, col)}
      light_or_dark_win = @game.board.win?(LIGHT) || @game.board.win?(DARK)
      if light_or_dark_win
        expect(@game.over?).to eq(light_or_dark_win)
      end
    end

    it "returns true when the board is full, but no winner" do
      light = false
      7.times do |col|
        6.times do |row|
          light = !light if row%2 == 0
          @game.board.place_piece(light ? LIGHT : DARK, col)
        end
      end
      expect(@game.over?).to eq(true)
    end

    it "returns false when no four in a row and board not full" do
      expect(@game.over?).to eq(false)
    end
  end
end