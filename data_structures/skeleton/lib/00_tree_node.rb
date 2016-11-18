class PolyTreeNode

  attr_reader :value, :children, :parent

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(node)
    @parent.children.reject! { |el| el == self } unless parent == nil
    @parent = node
    parent.children << self unless node == nil
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "Child not found" unless children.include?(node)
    node.parent = nil
    children.reject! { |el| el == node }
  end

  def get_leaves
    return [self] if self.children.empty?
    leaves = []
    children.each do |child|
      leaves += child.get_leaves
    end
    leaves
  end

  def dfs(value)
    return self if value == self.value
    children.each do |child|
      search_result = child.dfs(value)
      return search_result if search_result
    end
    nil
  end

  def bfs(value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == value
      queue += current_node.children
    end
  end

  def get_path
    path = []
    return [] if self.parent.nil?
    path << self.value
    path += self.parent.get_path
  end

  def inspect
    puts "#{self.value}"
  end
end
