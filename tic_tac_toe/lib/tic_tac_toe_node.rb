require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      @board.winner != evaluator
    else
      other_evaluator = (evaluator == :x ? :o : :x)
      children.any? do |child|
        child.winning_node?(other_evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      @board.winner == evaluator
    else
      other_evaluator = (evaluator == :x ? :o : :x)
      children.all? do |child|
        child.losing_node?(other_evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_arr = []
    @board.rows.each_with_index do |row, idx1|
      row.each_with_index do |square, idx2|
        if square.nil?
          new_board = @board.dup
          new_board[[idx1, idx2]] = @next_mover_mark
          new_mark = (@next_mover_mark == :x ? :o : :x)
          prev_move_pos = [idx1, idx2]
          child_arr << TicTacToeNode.new(new_board, new_mark, prev_move_pos)
        end
      end
    end
    child_arr
  end

  def inspect
    @board.rows.each { |row| p row }
  end
end

b = Board.new
b[[0,0]] = :x
b[[1,0]] = :o
b[[1,1]] = :o
ttn = TicTacToeNode.new(b, :x, nil)
p ttn.children
