require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "binding_of_caller"

# Need this configuration for better_errors
use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

def determine_winner(our_move, computer_move)
  if our_move == computer_move
    return 'We tied!', computer_move
  elsif (our_move == 1 && computer_move == 3) || (our_move == 2 && computer_move == 1) || (our_move == 3 && computer_move == 2)
    return 'We won!', computer_move
  else
    return 'We lost!', computer_move
  end
end

def generate_move
  rand(1..3)
end

get('/') do
  erb(:rules)
end

get('/rock') do
  our_move = 1
  computer_move = generate_move

  @outcome, @computer_move = determine_winner(our_move, computer_move)
  erb(:rock)
end

get('/paper') do
  our_move = 2
  computer_move = generate_move

  @outcome, @computer_move = determine_winner(our_move, computer_move)
  erb(:paper)
end

get('/scissors') do
  our_move = 3
  computer_move = generate_move

  @outcome, @computer_move = determine_winner(our_move, computer_move)
  erb(:scissors)
end
