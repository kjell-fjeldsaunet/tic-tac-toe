require_relative 'game'

# This file will initiate the game and handle the players

running = true
round_counter = 0
player1 = {}
player2 = {}

def get_players(player_one, player_two)
  players = [player_one, player_two]
  players.each_with_index do |player, index|
    puts "\nPlayer#{index + 1}, please enter your name: "
    player['name'] = gets.chomp
    puts "\n#{player['name']}, please select your symbol: "
    player['symbol'] = gets.chomp.upcase[0]
  end
end

puts "\n    ##################"\
"\n    ## Tic-Tac-Toe! ##"\
"\n    ##################"\
"\n\n"

while running
  game = Game.new
  if round_counter.zero?
    puts "Welcome! Let's play Tic-Tac-Toe!\n\n"
    get_players(player1, player2)
  else
    puts "\n\nGet ready for round #{round_counter + 1}!"
  end
  winner = game.play_round(player1, player2)

  if winner
    puts "\n\n\n### #{winner['name']} is the winner! ###\n\n\n"
  else
    puts "\n\n\nIts a draw!\n\n\n"
  end

  puts 'Do you want a rematch? [Y/N]'
  continue = gets.downcase.chomp
  running = false unless (continue == 'y') || (continue == 'yes')
  round_counter += 1
end
