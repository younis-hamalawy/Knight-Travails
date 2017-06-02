# An #initialize(value) method that sets the value, and starts parent as nil,
# and children to an empty array.
# A #parent method that returns the node's parent.
# A #children method that returns an array of children of a node.
# A #value method that returns the value stored at the node.
# Write a #parent= method which (1) sets the parent property and (2) adds
# the node to their parent's array of children (unless we're setting parent to nil).

class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def parent=(node)
    return @parent = nil if node.nil?
    if @parent
      @parent.remove_child(self)
      @parent = node
    else
      @parent = node
    end
    node.add_child(self) unless node.nil?
  end

  def add_child(node)
    @children << node unless @children.include?(node)
    node.parent=(self) unless node.parent == self

  end

  def remove_child(node)
    raise "not a valid child" unless @children.include?(node)
    node.parent= nil if node.parent
    @children.delete(node)
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |node|
      res = node.dfs(target)
      return res if res
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      curr = queue.shift
      return curr if curr.value == target
      queue.concat(curr.children)
    end
    nil
  end

end
