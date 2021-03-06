require_relative 'game_board'

# This class handles game logic
class Game
  LEGAL_MOVE_PATTERN = /[a-c][1-3]/.freeze

  def initialize
    @game_board = GameBoard.new
  end

  def play_round(player1, player2)
    (1..9).each do |turn|
      puts @game_board
      if turn.odd?
        make_move(player1)
        return player1 if game_over?
      else
        make_move(player2)
        return player2 if game_over?
      end
    end
    nil
  end

  def game_over?
    placed = @game_board.playfields
    column_line?(placed) || row_line?(placed) || cross_line?(placed)
  end

  private

  def make_move(player)
    puts "#{player['name']}, please make your move: "
    playermove = gets.downcase.chomp

    while !playermove.match?(LEGAL_MOVE_PATTERN) || !@game_board.field_is_free?(playermove)
      puts 'Invalid move, please try again.'
      playermove = gets.downcase.chomp
    end

    @game_board.place_symbol(playermove, player['symbol'])
  end

  def column_line?(placed)
    ('a'..'c').each do |column_coordinate|
      if (placed[column_coordinate + '1'] == placed[column_coordinate + '2']) &&
         (placed[column_coordinate + '1'] == placed[column_coordinate + '3']) &&
         (placed[column_coordinate + '1'] != ' ')

        return true
      end
    end
    false
  end

  def row_line?(placed)
    ('1'..'3').each do |row_coordinate|
      if (placed['a' + row_coordinate] == placed['b' + row_coordinate]) &&
         (placed['a' + row_coordinate] == placed['c' + row_coordinate]) &&
         (placed['a' + row_coordinate] != ' ')

        return true
      end
    end
    false
  end

  def cross_line?(placed)
    if (((placed['a1'] == placed['b2']) && (placed['a1'] == placed['c3'])) ||
      ((placed['a3'] == placed['b2']) && (placed['a3'] == placed['c1']))) &&
       (placed['b2'] != ' ')

      true
    end
    false
  end
end
