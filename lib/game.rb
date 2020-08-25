require_relative 'game_board'
class Game
  LEGAL_MOVE_PATTERN = /[a-c][1-3]/

  def initialize()
    @game_board = GameBoard.new # Get gameboard to use during game.
  end

  def make_move(player) 
    puts "#{player["name"]}, please make your move: " # Prompt to get input from player.
    playermove = gets.downcase.chomp

    while !playermove.match?(LEGAL_MOVE_PATTERN) || !@game_board.field_is_free?(playermove) do  # Check for legal move and free space.
      puts "Invalid move, please try again."
      playermove = gets.downcase.chomp
    end

    @game_board.place_symbol(playermove, player["symbol"]) # "Place" player symbol on board.
  end

  def play_round(player1, player2, round_counter)
    (1..9).each do |turn|
      puts @game_board
      if turn.odd?
        self.make_move(player1)
        return player1 if self.game_over?
      else
        self.make_move(player2)
        return player2 if self.game_over?
      end
    end

    return nil
  end

  def game_over? # Check if wincondition is met (row, column or across contains same symbol)
    placed = @game_board.playfields #Get hash over playfields
    
    ("a".."c").each do |column_coordinate|# Check all columns.
      if (
        (placed[column_coordinate + "1"] == placed[column_coordinate + "2"]) && # Check first and second.
        (placed[column_coordinate + "1"] == placed[column_coordinate + "3"]) && # Check first and third.
        (placed[column_coordinate + "1"] != " ")# Check that they are not just empty.
      ) 
        return true
      end
    end

    # Check all rows
    (1..3).each do |row_coordinate|
      if (
        (placed["a" + row_coordinate.to_s] == placed["b" + row_coordinate.to_s]) &&
        (placed["a" + row_coordinate.to_s] == placed["c" + row_coordinate.to_s]) &&
        (placed["a" + row_coordinate.to_s] != " ")
      )
        return true
      end
    end

    # Check crosses
    if (
      ((placed["a1"] == placed["b2"] and placed["a1"] == placed["c3"]) ||
      (placed["a3"] == placed["b2"] and placed["a3"] == placed["c1"])) &&
      (placed["b2"] != " ")
    )
      return true
    end

    false # Return false if no wincondition detected

  end

  #def print_board
  #  puts @game_board
  #end
end
