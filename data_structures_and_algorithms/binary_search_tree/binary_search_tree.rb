class Node
	attr_accessor :value, :parent, :left, :right

	def initialize(value, parent = nil)
		@value = value
		@parent = parent
	end
end

class Tree
	attr_accessor :root

	def build_tree(array)
		@root = Node.new(array[0])
		array[1..-1].each do | value |
		cur_node = @root			
			while true
				if value < cur_node.value
					if cur_node.left
						cur_node = cur_node.left
					else
						cur_node.left = Node.new(value, cur_node)
						break						
					end
				else
					if cur_node.right
						cur_node = cur_node.right
					else
						cur_node.right = Node.new(value, cur_node)
						break						
					end
				end
			end
		end
	end

	def breadth_first_search(value)
		queue = [@root]
		visited = [@root]
		cur_node = @root
		return cur_node if cur_node.value == value
		while queue.size > 0
			cur_node = queue.shift
			if cur_node.left
				return cur_node.left if cur_node.left.value == value
				queue << cur_node.left
				visited << cur_node.left
			end
			if cur_node.right
				return cur_node.right if cur_node.right.value == value
				queue << cur_node.right
				visited << cur_node.right
			end
		end
		nil
	end

	def depth_first_search(value)
		stack = [@root]
		visited = [@root]
		while stack.size > 0
			cur_node = stack[-1]
			return cur_node if cur_node.value == value
			if cur_node.left && !visited.include?(cur_node.left)
				return cur_node.left if cur_node.left.value == value
				stack << cur_node.left
				visited << cur_node.left
			elsif cur_node.right && !visited.include?(cur_node.right)
				return cur_node.right if cur_node.right.value == value
				stack << cur_node.right
				visited << cur_node.right
			else
				stack.pop
			end
		end
		nil
	end

	def dfs_rec(value, stack = [@root], visited = [@root], cur_node = stack[-1])
		return nil if stack.size == 0
		return cur_node if cur_node.value == value
		if cur_node.left
			dfs_rec(value, stack << cur_node.left, visited << cur_node.left)
		else
			stack.pop
		end
		if cur_node.right
			dfs_rec(value, stack << cur_node.right, visited << cur_node.right)
		else
			stack.pop
		end
	end	
end

array = [4,1,0, -99, 23, 3, 5, 199, 8, 2]

tree = Tree.new
tree.build_tree(array)
puts tree.breadth_first_search(23)
puts tree.depth_first_search(23)
puts tree.dfs_rec(23)