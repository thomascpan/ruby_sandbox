Cell = Struct.new(:value)
hints_grid = Array.new(12) {Array.new(4) {Cell.new('A')}}


temp = hints_grid.map do |row|
	row.map {|cell| cell.value}
end



print temp.any? {|row| row == ["B", "B", "B", "B"]}