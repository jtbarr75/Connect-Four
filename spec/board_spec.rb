require './lib/board'

describe Board do
  before(:each) { @board = Board.new }
  B = "\u{25EF}"
  DARK ||= "\u{263A}"
  LIGHT ||= "\u{263B}"

  describe "#create_grid" do
    it "creates a 7x6 grid of #{B} (circles)" do
      expect(@board.grid).to eq( [[B, B, B, B, B, B, B],
                                 [B, B, B, B, B, B, B],
                                 [B, B, B, B, B, B, B],
                                 [B, B, B, B, B, B, B],
                                 [B, B, B, B, B, B, B],
                                 [B, B, B, B, B, B, B]] )
    end
  end

  describe "#print_grid" do
    it "prints the grid in correct format" do 
      expected = 
      <<~EXPECTED
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      EXPECTED
      expect { @board.print_grid }.to output(expected).to_stdout
    end
  end

  describe "#place_piece" do
    it "places the indicated piece in the correct location" do
      @board.place_piece("\u{263A}", 0)
      expected = 
      <<~EXPECTED
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{B} #{B} #{B} #{B} #{B} #{B} #{B}
      #{DARK} #{B} #{B} #{B} #{B} #{B} #{B}
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

  describe "#win?" do
    context "returns true if player has four in a row" do
      example "horizontally" do
        4.times { |col| @board.place_piece(LIGHT, col)}
        expect(@board.win?(LIGHT)).to eq(true)
      end

      example "vertically" do
        4.times { @board.place_piece(LIGHT, 0)}
        expect(@board.win?(LIGHT)).to eq(true)
      end

      example "diagonally" do
        0.upto(3) do |i|
          i.times { @board.place_piece(LIGHT, i) }
          @board.place_piece(DARK, i)
        end
        expect(@board.win?(DARK)).to eq(true)
      end
    end

    context "returns false" do
      example "with no pieces" do
        expect(@board.win?(LIGHT)).to eq(false)
      end

      example "with 4 in row but one piece different" do
        3.times { @board.place_piece(LIGHT, 0)}
        @board.place_piece(DARK, 0)
        expect(@board.win?(LIGHT)).to eq(false)
      end
    end
  end
end