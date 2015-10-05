def bubble_sort(array)
	moved = true
	while moved == true do 
		moved = false 
		array.each_with_index do |number, index|
			temp_number = number
			if array[index+1] == nil
			elsif number > array[index+1]
				array[index] = array[index+1]
				array[index+1] = temp_number
				moved = true
			end
		end
	end
	print array
end

bubble_sort([8, 9, 4, 2 , 5, 7, 1, 1])