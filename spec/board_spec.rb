require './lib/board'

describe Board do
  before(:each) { @board = Board.new }

  describe "#create_grid" do
    it "Creates a 7x6 grid of \u{25EF} (circles)" do
      expect(@board.grid).to eq( [["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"],
                                 ["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"],
                                 ["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"],
                                 ["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"],
                                 ["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"],
                                 ["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"]] )
    end
  end

  describe "#print_grid" do
    it "Prints the grid in correct format" do 
      expected = 
      <<~EXPECTED
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      EXPECTED
      expect { @board.print_grid }.to output(expected).to_stdout
    end
  end

  describe "#place_piece" do
    it "Places the indicated piece in the correct location" do
      @board.place_piece("\u{263A}", 0)
      expected = 
      <<~EXPECTED
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{263A} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      EXPECTED
      expect { @board.print_grid }.to output(expected).to_stdout
    end
  end

  describe "#available_columns" do
    it "returns the columns with >= 1 blank space in empty grid" do
      expect(@board.available_columns).to eq([0,1,2,3,4,5,6])
    end

    it "returns the columns with >= 1 blank space in partially full grid" do
      6.times {@board.place_piece("\u{263A}", 0)}
      expect(@board.available_columns).to eq([1,2,3,4,5,6])
    end

    it "returns empty array if no columns have any spaces" do
      7.times do |col|
        6.times {@board.place_piece("\u{263A}", col)}
      end
      expect(@board.available_columns).to eq([])
    end
  end
end