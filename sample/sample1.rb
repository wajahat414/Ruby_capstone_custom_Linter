#!/usr/bin/env ruby

# rubocop: disable Metrics/BlockLength
require_relative '../lib/game_logic'

# board

# Description/Explanation of class board
class TicTac
  #:nodoc:
  def initialize; end

  def numeric?(obj)
    !obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
  end
end

instance = Board.new
Tic = TicTac.new
puts 'Welcome to Ruby"s Tic Tac Toe'
puts 'Enter first player name:'
name1 = gets.chomp
loop do
  if name1 == ''
    puts 'empty string please input valid name'
  elsif Tic.numeric? name1
    puts 'name can not be integer please input valid name'
  else
    break
  end
  name1 = gets.chomp
end

puts 'Enter second player name:'
name2 = gets.chomp

loop do
  if name2 == ''
    puts 'empty string please input valid name'
  elsif Tic.numeric? name2
    puts 'name can not be integer please input valid name'
  else
    break
  end
  name2 = gets.chomp
end

puts "#{name1} will play with  X and #{name2} will play with  O"

x = 0
num_turn = 0
loop do
  puts `clear`
  puts instance.display_board
  puts "\n"
  if num_turn == 9
    puts 'The game is drawn no player won'
    sleep(3)
    return
  end
  if x.zero?
    puts "Its #{name1} turn! \n Please select the available cell from the board"
    cell = gets.chomp.to_i
    while instance.playerturn(cell, x)
      puts 'invalid move Please enter a valid number from 1 - 9!'
      cell = gets.chomp.to_i
    end

    if instance.checkwinner
      puts `clear`
      puts instance.display_board
      puts "#{name1} is the Winner"
      sleep(3)
      return
    end

    x = 1

  else
    puts "Its #{name2} turn!"
    puts "\n"
    puts 'Please select the available cell from the board'
    cell = gets.chomp.to_i
    while instance.playerturn(cell, x)
      puts 'invalid move Please enter a valid number from 1 - 9!'
      cell = gets.chomp.to_i
    end

    if instance.checkwinner
      puts `clear`
      puts instance.display_board
      puts "#{name2} is the Winner"
      return
    end
    x = 0
  end
  num_turn += 1
end

# rubocop: enable Metrics/BlockLength
