module Enumerable 
	def my_each
		return self.to_enum unless block_given?
		for i in self
			yield(i)
		end
	end

	def my_each_with_index
		return self.to_enum unless block_given?
		index = 0
		for i in self
			yield(i, index)
			index += 1
		end
	end

	def my_select
		return self.to_enum unless block_given?
		temp_self = []
		self.my_each do |j|
			if yield(j) == true
				temp_self << j 
			else 
			end
		end
		return temp_self
	end

	def my_all?

		if block_given?
			result = true
			for i in self
				if yield(i) == true
				else 
					return false
				end
			end
			return true
		else
			for i in self
				if i != nil && i != false
				else
					return false
				end
			end
			return true
		end
	end

	def my_any?
		if block_given?
			result = false
			for i in self 
				if yield(i) == true
					return true
				else
				end
			end
			return false
		else
			for i in self 
				if i != false && i != nil
					return true
				end
			end
			false
		end
	end

	def my_none?
		if block_given?
			result = true
			for i in self
				if yield(i) == false
				else
					return false
				end
			end
			return true
		else
			for i in self 
				if i == false || i == nil
				else
					return false
				end
			end
			return true
		end
	end

	def my_count(*arg)
		return self.size unless block_given? || arg != []
		j = 0
		if block_given?
			for i in self
				if yield(i) == true
					j += 1
				end
			end
		else
			for i in self
				if i == arg[0]
					j += 1
				end
			end
		end
		return j
	end
	# def my_map
	# 	return self unless block_given?
	# 	new_array = []
	# 	for i in self
	# 		new_array.push(yield(i))
	# 	end
	# 	return new_array 
	# end

	def my_map(&proc)
		return self.to_enum unless block_given?
		new_array = []
		for i in self 
			new_array.push(proc.call(i))
		end
		return new_array
	end	

  def my_inject(initial=nil,sym=nil)

      result = initial.nil? ? self[0] : initial

      if block_given?
          for i in 2..self.size
              result = yield(result,i)
          end
      else
          if sym.nil?
              sym = initial
              initial = nil
          end

          for i in self
              if initial.nil?
                  initial = i
                  result = initial
              else
                  result = result.send(sym,i)
              end
          end
      end

      return result
  end
end

# def multiply_els(array)
# 	return array.my_inject() {|x,y| x*y}
# end

a = [1, 2, 3]
# b = []
# add = Proc.new {|x| x+2}
# a.my_each {|x| puts x}
# a.my_each_with_index {|x, index| puts "#{x}: #{index}"}
# test_variable = [1, 2, 3, 8, 7, 4].my_select {|x| x <= 6}
# puts test_variable
# puts a.my_all? {|x| x < 2}
# puts a.my_any? {|x| x < 2}
# puts a.my_none? {|x| x > 2}
# puts a.my_count
# puts b.my_count
# puts a.my_inject(0) {|x, y| x+y}
# puts [1, 2, 3, 4].my_inject(0) {|x, y| x+y}
# puts [1,2,3,4].my_inject(2) { |result, element| result + element }
# puts [1,2,3,4,5,6].my_inject([]) do |result, element|
#   result << element  if element % 2 == 0
#   result
# end
# puts (5..10).inject { |sum, n| sum + n }
# puts [1,2,3,4,5].my_inject(0,:+)
# puts [1,2,3,4,5].my_inject(5,:+)
# puts [1,2].my_inject(1,:*)
# puts [9,2].my_inject(:+)
# puts [2,4,5].my_inject(:*)

# puts multiply_els([2, 4, 5])
# puts a.my_map(&add)
# puts a.my_map(&add) {|x| x+1}

a = [1, 2, 3]
a.each