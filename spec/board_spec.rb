require './lib/board'

describe Board do
  let(:board) { board = Board.new }

  describe "#create_grid" do
    it "Creates a 7x6 grid of \u{25EF} (circles)" do
      expect(board.grid).to eq( [["\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}", "\u{25EF}"],
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
      expect { board.print_grid }.to output(expected).to_stdout
    end
  end

  describe "#place_piece" do
    it "Places the indicated piece in the correct location" do
      board.place_piece("\u{263A}", 0)
      expected = 
      <<~EXPECTED
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      \u{263A} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF} \u{25EF}
      EXPECTED
      expect { board.print_grid }.to output(expected).to_stdout
    end
  end
end