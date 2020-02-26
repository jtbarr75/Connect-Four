require './lib/game'

describe Game do
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
        "Please choose a column from (0, 1, 2, 3, 4, 5, 6)\n"
      ).to_stdout
    end
  end 

  describe "#game_over?" do
    it "returns true if one player has four in a row" do

    end

    it "returns true if board is full" do

    end

    it "returns false otherwise" do
      
    end
  end
end