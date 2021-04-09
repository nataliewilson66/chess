require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
  
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = { "player1" => HumanPlayer.new(:black, @display), "player2" => HumanPlayer.new(:white, @display) }
    @current_player = @players["player1"]
  end

  def play
    while !(@board.checkmate?(:black) || @board.checkmate?(:white))
      begin
        @current_player.make_move(@board)
      rescue StandardError => e
        if e.message == "no piece at selected position"
          puts "no piece at selected position, try again"
          sleep(2)
        elsif e.message == "piece cannot move like that"
          puts "piece cannot move like that, try again"
          sleep(2)
        elsif e.message == "move will leave you in check"
          puts "move will leave you in check, try again"
          sleep(2)
        end
        retry
      end

      if @current_player == @players["player1"]
        @current_player = @players["player2"]
      else
        @current_player = @players["player1"]
      end
    end
  end

end

my_game = Game.new
my_game.play