require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def symbol
    symbol = color == :black ? "\u265D" : "\u2657"
    symbol.encode("utf-8")
  end

  protected
  def move_dirs
    diagonal_dirs
  end

end