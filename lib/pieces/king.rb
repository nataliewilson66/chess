require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable

  def symbol
    symbol = color == :black ? "\u265A" : "\u2654"
    symbol.encode("utf-8")
  end

  protected
  def move_diffs
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
  end

end