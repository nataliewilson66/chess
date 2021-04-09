module Stepable

  def moves
    moves = []
    move_diffs.each do |diff|
      dx, dy = diff
      curr_x, curr_y = pos
      new_pos = [curr_x + dx, curr_y + dy]
      if board.valid_pos?(new_pos)
        moves << new_pos if board[new_pos].empty? || board[new_pos].color != color
      end
    end
    moves
  end

  private
  def move_diffs
    # subclass implements this
    raise NotImplementedError
  end

end