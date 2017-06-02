require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder

  attr_accessor :root

  def initialize(pos = [0,0])
    @pos = pos
    @visited_positions = [pos]
    # @move_tree
    build_move_tree
  end

  def find_path(end_pos)
    foundnode = @root.bfs(end_pos)
    trace_path_back(foundnode)
  end

  def trace_path_back(node)
    arr = []
    until node.parent.value == root.value
      arr.unshift(node.value)
      node = node.parent
    end
    arr.unshift(root.value)
  end

  def build_move_tree
    self.root = PolyTreeNode.new(@pos)
    queue = [root]
    until queue.empty?
      curr = queue.shift
      # byebug
      moves = new_move_positions(curr.value)
      moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = curr
        queue << node
      end
    end

  end

  def self.valid_moves(pos)
    arr = []
    row, col = pos
    delta = [[1, 2], [2, 1], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    delta.each do |del|
      newrow = row + del.first
      newcol = col + del.last
      if newrow >= 0 && newrow <= 7 && newcol >= 0 && newcol <= 7
        arr << [newrow, newcol]
      end
    end
    arr
  end

  def new_move_positions(pos)
    pot_moves = []
    KnightPathFinder.valid_moves(pos).each do |pot_pos|
      pot_moves << pot_pos unless @visited_positions.include?(pot_pos)
    end
    @visited_positions.concat(pot_moves)
    pot_moves
  end

end
