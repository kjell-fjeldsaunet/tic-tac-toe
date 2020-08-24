require_relative 'game'
require_relative 'game_board'

running = true
reset = false
round_counter = 0
player1 = Hash.new
player2 = Hash.new

def get_players(p1, p2)
  puts "Player 1, please enter your name: "
  p1["name"] = gets.chomp
  puts "\n#{p1["name"]}, please select your symbol: "
  p1["symbol"] = gets.chomp.upcase[0]

  puts "\nPlayer 2, please enter your name: "
  p2["name"] = gets.chomp
  puts "\n#{p2["name"]}, please select your symbol: "
  p2["symbol"] = gets.chomp.upcase[0]
end

puts "##################
## Tic-Tac-Toe! ##
##################
\n\n"

while running do
  game = Game.new
  if round_counter == 0
    puts "Welcome! Let's play Tic-Tac-Toe!\n\n"
    get_players(player1, player2)
  elsif reset
    round_counter = 0
    puts "\n\nAre the new players ready?"
    get_players(player1, player2)
  else 
    puts "\n\nGet ready for round #{round_counter + 1}!"
  end
  winner = game.play_round(player1, player2, round_counter)

  if winner
    puts "#{winner["name"]} is the winner!\n\n\n"
  else
    puts "Its a draw!\n\n\n"
  end

  puts "Do you want a rematch? [Y/N]"
  continue = gets.downcase.chomp
  unless continue == "y" or continue =="yes"
    running = false
  end
  round_counter += 1
end

puts player1