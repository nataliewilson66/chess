require_relative 'player'

class HumanPlayer < Player

  def make_move(board)
    start_pos = display.run
    end_pos = display.run
    board.move_piece(start_pos, end_pos)
    display.render
  end

  def input_loop
    input = display.cursor.get_input
    if input != nil
      return input
    else
      return input_loop
    end
  end

end