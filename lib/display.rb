require_relative 'cursor'
require_relative 'board'

class Display

  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @debug = true
  end

  def render
    (0...8).each do |row|
      (0...8).each do |col|
        pos = [row, col]
        if pos == @cursor.cursor_pos
          background_color = :red
        elsif (row + col) % 2 == 0
          background_color = :white
        else
          background_color = :light_white
        end
        print @board[pos].to_s.colorize(:background => background_color)
      end
      puts
    end
  end

  def run
    input = nil
    while input == nil
      system("clear")
      self.render
      input = @cursor.get_input
    end
    input
  end

end