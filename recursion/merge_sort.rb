def merge_sort(array=[])
	return array if array.size == 1 

	mid = array.size/2 

	a1 = array[0...mid]
	a2 = array[mid..-1]

	a1 = merge_sort(a1)
	a2 = merge_sort(a2)

	result = []
	idx1 = 0
	idx2 = 0

	while result.size < (a1.size + a2.size)
		if idx1 == a1.size
			(result << a2[idx2..-1]).flatten!
		elsif idx2 == a2.size
			(result << a1[idx1..-1]).flatten!	
		elsif a1[idx1] <= a2[idx2]
			result << a1[idx1]
			idx1 += 1
		elsif a2[idx2] <= a1[idx1]
			result << a2[idx2]
			idx2 += 1
		end
	end

	return result
end

a = [1, 3, 2, 10, -9, 12, 4, 3, 2, 4, 1223, 44, 9, 12, 8]
p merge_sort(a)