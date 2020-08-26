# This class will keep a record of the game board and the placement of symbols on it.
class GameBoard
  def initialize
    @playfields = {}
    ('a'..'c').each do |column_coordinate| # Populate hash with playfields (a1, a2 etc.) as keys
      (1..3).each do |row_coordinate|
        playfield = column_coordinate + row_coordinate.to_s
        @playfields[playfield] = ' '
      end
    end
  end

  def to_s
    "\n\n   A   B   C\n1  #{@playfields['a1']} | #{@playfields['b1']} | #{@playfields['c1']} \n  -----------\n2  #{@playfields['a2']} | #{@playfields['b2']} | #{@playfields['c2']} \n  -----------\n3  #{@playfields['a3']} | #{@playfields['b3']} | #{@playfields['c3']}\n\n"
  end

  def place_symbol(playfield, symbol)
    @playfields[playfield] = symbol
  end

  def field_is_free?(playfield)
    @playfields[playfield] == ' '
  end

  attr_reader :playfields
end
