require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable

  def symbol
    symbol = color == :black ? "\u265C" : "\u2656"
    symbol.encode("utf-8")
  end

  private
  def move_dirs
    horizontal_dirs
  end

end