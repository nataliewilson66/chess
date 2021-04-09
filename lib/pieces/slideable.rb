module Slideable
  
  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves_arr = []
    curr_x, curr_y = pos
    move_dirs.each do |dx, dy|
      moves_arr.concat(grow_unblocked_moves_in_dir(dx, dy))
    end
    moves_arr
  end

  private
  HORIZONTAL_DIRS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  DIAGONAL_DIRS = [[-1, -1], [1, 1], [-1, 1], [1, -1]]

  def move_dirs
    # subclass implements this
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    moves = []
    curr_x, curr_y = pos
    mult = 1
    new_pos = [curr_x + dx, curr_y + dy]
    while board.valid_pos?(new_pos) && board[new_pos].empty?
      moves << new_pos
      mult += 1
      new_pos = [curr_x + (mult * dx), curr_y + (mult * dy)]
    end
    moves << new_pos if board.valid_pos?(new_pos) && board[new_pos].color != self.color
    moves
  end

end