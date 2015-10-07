class Node
	attr_accessor :position, :parent

	def initialize(position, parent = nil)
		@position = position
		@parent = parent
	end
end

def possible_moves(node)
	x = node.position.first
	y = node.position.last
	moves = [
		[x + 1, y + 2],[x + 2, y + 1],
		[x + 1, y - 2],[x + 2, y - 1],
		[x - 1, y + 2],[x - 2, y + 1],
		[x - 1, y - 2],[x - 2, y - 1], 
	]
	moves.select { |move| move[0] >= 0 && move[0] <= 7 && move[1] >= 0 && move[1] <= 7 }
end

def knight_moves(start_pos, end_pos)
	node = Node.new(start_pos)
	queue = [node]
	visited = [node.position]

	loop do 
		node = queue.shift
		break if node.position == end_pos
		possible_moves(node).each do | move |
			if visited.include?(move)
				next
			else
				child = Node.new(move, node)
				queue << child
				visited << child.position
			end
		end
	end
	print_parents(node)
end

def print_parents(node)
	path = [node.position]
	until node.parent == nil
		path << node.position
		node = node.parent 
	end

	puts "You made it in #{path.size - 1} moves! Here's your path:"
	path.reverse.each { |move| p move}
end

knight_moves([0,0], [7,7])