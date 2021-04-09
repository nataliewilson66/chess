require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable
  
  def symbol
    symbol = color == :black ? "\u265B" : "\u2655"
    symbol.encode("utf-8")
  end

  private
  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end