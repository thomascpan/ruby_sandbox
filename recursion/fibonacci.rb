def fibs(n)
  array = []
  array[0] = 0
  array[1] = 1
  i = 2
  while i <= n 
    array << array[i-2] + array[i-1]
    i+=1
  end
  array[n]
end


def fibs_rec(n)
  return 0 if n == 0
  return 1 if n == 1
  return fibs_rec(n-2) + fibs_rec(n-1)
end

puts fibs(6)
puts fibs_rec(6)