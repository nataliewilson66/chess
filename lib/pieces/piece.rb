class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    board.add_piece(self, pos)
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    false
  end

  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  def symbol
    # subclass implements this
    raise NotImplementedError
  end

  private
  def move_into_check?(end_pos)
    new_board = board.dup
    new_board.move_piece!(pos, end_pos) 
    new_board.in_check?(color)
  end

end