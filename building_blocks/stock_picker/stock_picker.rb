def stock_picker(array)
	all_combinations = []
	combination = [0, 0]
	all_profits = []
	profit = 0 

	i = 0 
	while i < array.length do 
		j = i + 1
		while j < array.length do
			buy_price = array[i]
			sell_price = array[j]
			profit = sell_price.to_i - buy_price.to_i
			all_profits.push(profit)
			combination = [buy_price, sell_price]
			all_combinations.push(combination)
			j += 1
		end
		i += 1
	end
	index = all_profits.index(all_profits.max)
	p all_combinations[index]
end

stock_picker([4, 3, 15])
stock_picker([5, 13, 15, 70, 37, 81, 21])
stock_picker([15, 3])
stock_picker([4, 3, 15, 2])

# i=0
# 0<1
# j=1
# 1<=1
# bp=15
# sp=3
# p=3-15=-12
# ap = [-12]
# c =[15, 3]
# ac=[[15,3]]
# j=2
# ap.max=-12
# ap.index=0
# [15,3]



# all_combinations = [[4,3], [4, 15], [3, 15]]
# combination = [3, 15]
# all_profits = [-1, 11, 12]
# profit = 12 

# i=0
# 0<2
# j=1
# 1<=2
# bp=4
# sp=3
# p=3-4=-1
# j=2
# 2<=2
# bp=4
# sp=15
# p=15-4=11
# j=3
# i=1
# 1<2
# j=2
# 2<=2
# bp=3
# sp=15
# p=15-3=12
# j=3
# i=2

# all_profits.max = 12
# all_profits.index = 2
# index = 2