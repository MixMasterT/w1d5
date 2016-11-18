require_relative '../data_structures/skeleton/lib/00_tree_node'
require_relative "board"

class KnightPathFinder
  DELTAS = [[1, 2], [2, 1], [-1, 2], [-2, 1],
            [-2, -1], [-1, -2], [1, -2], [2, -1]]

  def initialize(pos)
    @start = pos
    @board = Board.new
    @board[@start] = 'S'
    @visited_pos = []
  end

  def build_move_tree
    @tree ||= PolyTreeNode.new(@start)
  end

  def add_children(node)
    pos = node.value
    next_pos = get_next_pos(pos)
    @visited_pos += next_pos
    next_pos.each { |p| node.add_child(PolyTreeNode.new(p)) }
  end

  def find_path(target_pos, max_depth = 50)
    current_pos = @start
    build_move_tree
    until @tree.bfs(target_pos)
      leaves = @tree.get_leaves
      # p leaves
      leaves.each { |leaf| add_children(leaf) }
    end
    path = @tree.bfs(target_pos).get_path
    p path
    place_mark(path.reverse)
    render
    clear
  end


  def get_next_pos(pos = @start)
    possible_next_pos = DELTAS.map { |move|  [pos[0] + move[0], pos[1] + move[1]] }
    possible_next_pos.select! { |p| valid_pos?(p) }
    possible_next_pos.reject { |p| @visited_pos.include?(p) }
  end

  def valid_pos?(pos)
    pos.all? { |el| el.between?(0, @board.size - 1) }
  end

  def place_mark(path)
    path.each_with_index { |p, i| @board[p] = i+1 }
  end

  def render
    @board.render
  end

  def clear
    @board = Board.new
    @board[@start] = "S"
  end


end

kpf = KnightPathFinder.new([0,0])
kpf.find_path([5,5])
kpf.find_path([7,7])
kpf.find_path([0,1])
