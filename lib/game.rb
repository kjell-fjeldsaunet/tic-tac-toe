require_relative 'game_board'
class Game
  def initialize()
    @game_board = GameBoard.new
    @legal_move = /[a-c][1-3]/
  end

  def make_play(play, player)
    @game_board.place_symbol(play, player["symbol"])
  end

  def get_move(player)
    puts "#{player["name"]}, please make your move: "
    playermove = gets.downcase.chomp
    while !playermove.match?(@legal_move) or !@game_board.field_is_free?(playermove) do
      puts "Invalid move, please try again."
      playermove = gets.downcase.chomp
    end
    self.make_play(playermove, player)
  end

  def play_round(player1, player2, round_counter)
    (1..9).each do |turn|
      self.print_board
      if turn.odd?
        self.get_move(player1)
        if self.game_over? then return player1 end
      else
        self.get_move(player2)
        if self.game_over? then return player2 end
      end
    end
    return nil
  end

  def game_over?
    placed = @game_board.playfields
    #Check all columns
    ("a".."c").each do |column_coordinate|
      if ((placed[column_coordinate + "1"] == placed[column_coordinate + "2"]) and (placed[column_coordinate + "1"] == placed[column_coordinate + "3"]) and (placed[column_coordinate + "1"] != " "))
        return true
      end
    end
    #check all rows
    (1..3).each do |row_coordinate|
      if ((placed["a" + row_coordinate.to_s] == placed["b" + row_coordinate.to_s]) and (placed["a" + row_coordinate.to_s] == placed["c" + row_coordinate.to_s]) and (placed["a" + row_coordinate.to_s] != " "))
        return true
      end
    end
    #Check crosses
    if (((placed["a1"] == placed["b2"] and placed["a1"] == placed["c3"]) or (placed["a3"] == placed["b2"] and placed["a3"] == placed["c1"])) and (placed["b2"] != " "))
      return true
    end
    false
  end

  def print_board
    puts @game_board
  end
end

#player1 = {
#  "name" => "Kjell",
#  "symbol" => "X"
#}

#player2 = {
#  "name" => "Sofie",
#  "symbol" => "O"
#}

#test_game = Game.new
#puts test_game.game_board
#puts test_game.game_over?
#(1..3).each do |i|
#  test_game.make_play("a#{i}", player1)
#  test_game.make_play("b#{i}", player2)
#end
#puts test_game.game_board
#puts test_game.game_over?