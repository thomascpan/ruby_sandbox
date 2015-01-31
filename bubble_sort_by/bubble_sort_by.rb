def bubble_sort_by(array)
	moved = true
	while moved == true do
		moved = false
		array.each_with_index do |element, index|
			left = array[index]
			right = array[index+1]
			if array[index+1] == nil
			else
				x = yield(left, right)
				if x > 0 
					array[index] = right
					array[index+1] = left
					moved = true
				else
				end
			end
		end
	end
	print array
end


bubble_sort_by(['hi', 'hello', 'hey']) do |left, right|
	left.length - right.length
end