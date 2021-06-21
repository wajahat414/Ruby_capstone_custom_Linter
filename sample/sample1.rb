#!/usr/bin/env ruby

# rubocop: disable Metrics/BlockLength
require_relative '../lib/game_logic'

# board TicTac
class board
  #:nodoc:
  def initialize; end

  def numeric?(obj)
    !obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
  end
end

# rubocop: disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity,  Metrics/AbcSize


class Board
  #:nodoc:
  attr_accessor :board

  def initialize
    @board = (1..9).to_a
  end

  def display_board
    " #{board[0]} | #{board[1]} | #{board[2]} \n" \
    "+---+---+---+\n" \
    " #{board[3]} | #{board[4]} | #{board[5]} \n" \
    "+---+---+---+\n" \
    " #{board[6]} | #{board[7]} | #{board[8]} \n" \
  end

  def checkwinner
    return true if board[0] == board[1] && board[1] == board[2]

    return true if board[3] == board[4] && board[4] == board[5]

    return true if board[6] == board[7] && board[7] == board[8]

    return true if board[0] == board[3] && board[3] == board[6]

    return true if board[1] == board[4] && board[4] == board[7]

    
    return true if board[2] == board[5] && board[5] == board[8]

    return true if board[0] == board[4] && board[4] == board[8]

    return true if board[2] == board[4] && board[4] == board[6]

    false
   end

  def playerturn(cell_num, turn)
    if cell_num >= 1 && cell_num <= 9 && board[cell_num - 1] == cell_num
      board[cell_num - 1] = if turn.zero?
                              'X'
                            else
                              'O'
                            end
      return false
    end
    true
   end
 end

# rubocop: enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity,  Metrics/AbcSize

# rubocop: enable Metrics/BlockLength
