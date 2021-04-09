require_relative 'piece'

class Pawn < Piece

  def symbol
    symbol = color == :black ? "\u265F" : "\u2659"
    symbol.encode("utf-8")
  end

  def moves
    valid_moves = []
    valid_moves.concat(forward_steps)
    valid_moves.concat(side_attacks)
    valid_moves
  end

  private
  def forward_dir
    return 1 if self.color == :black
    -1
  end

  def forward_steps
    dir = forward_dir
    row, col = self.pos
    steps = []
    if self.board[[row + dir, col]].empty?
      steps << [row + dir, col]
      if self.board[[row + (2 * dir), col]].empty?
        steps << [row + (2 * dir), col]
      end
    end
    steps
  end

  def side_attacks
    dir = forward_dir
    row, col = self.pos
    new_pos = [row + dir, col - 1]
    attacks = []
    if self.color == :black
      opponent_color = :white
    else
      opponent_color  = :black
    end
    attacks << new_pos if board.valid_pos?(new_pos) && board[new_pos].color == opponent_color
    new_pos = [row + dir, col + 1]
    attacks << new_pos if board.valid_pos?(new_pos) && board[new_pos].color == opponent_color
    attacks
  end

end