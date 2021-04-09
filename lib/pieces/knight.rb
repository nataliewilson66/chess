require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include Stepable

  def symbol
    symbol = color == :black ? "\u265E" : "\u2658"
    symbol.encode("utf-8")
  end

  protected
  def move_diffs
    [[-2, -1],
     [-2, 1],
     [-1, -2],
     [-1, 2],
     [1, -2],
     [1, 2],
     [2, -1],
     [2, 1]]
  end

end