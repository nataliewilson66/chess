require 'colorize'
require_relative 'pieces'

class Board

  def initialize(fill = true)
    @rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    fill_board if fill == true
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    raise 'Invalid position' unless valid_pos?(pos)
    row, col = pos
    @rows[row][col] = val
  end

  def valid_pos?(pos)
    row, col = pos
    if (row >= 0 && row < 8) &&
        (col >= 0 && col < 8)
      return true
    end
    false
  end

  def pieces(color)
    pieces = []
    @rows.each do |row|
      row.each do |elem|
        pieces << elem if elem.color == color
      end
    end
    pieces
  end

  def in_check?(color)
    king_pos = find_king(color)
    if color == :black
      opponent_color = :white
    else
      opponent_color = :black
    end
    opponent_pieces = pieces(opponent_color)
    opponent_pieces.each do |piece|
      return true if piece.moves.include?(king_pos)
    end
    false
  end

  def checkmate?(color)
    if in_check?(color)
      player_pieces = pieces(color)
      player_moves = []
      player_pieces.each { |piece| player_moves << piece.valid_moves }
      return true if player_moves.empty?
    end
    false
  end

  def move_piece(start_pos, end_pos)
    curr_piece = self[start_pos]
    if curr_piece.empty?
      raise StandardError.new 'no piece at selected position'
    elsif !curr_piece.moves.include?(end_pos)
      raise StandardError.new 'piece cannot move like that'
    elsif !curr_piece.valid_moves.include?(end_pos)
      raise StandardError.new 'move will leave you in check'
    end
    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    curr_piece = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos] = curr_piece
    curr_piece.pos = end_pos
  end

  def add_piece(piece, pos)
    if !valid_pos?(pos) && self[pos].empty?
      raise 'invalid position'
    end
    self[pos] = piece
  end

  def dup
    dup_board = Board.new(false)
    all_pieces = pieces(:black) + pieces(:white)
    all_pieces.each do |piece|
      piece.class.new(piece.color, dup_board, piece.pos)
    end
    dup_board 
  end

  private

  def fill_pawns(color)
    row = color == :black ? 1 : 6
    (0...8).each do |col|
      @rows[row][col] = Pawn.new(color, self, [row, col])
    end
  end

  def fill_pieces(color)
    row = color == :black ? 0 : 7
    back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    back_pieces.each_with_index do |type, col|
      type.new(color, self, [row, col])
    end
  end

  def fill_board
    [:black, :white].each do |color|
      fill_pieces(color)
      fill_pawns(color)
    end
  end

  def find_king(color)
    @rows.each do |row|
      row.each do |elem|
        return elem.pos if elem.is_a?(King) && elem.color == color
      end
    end
    raise 'no king found!'
  end

end
