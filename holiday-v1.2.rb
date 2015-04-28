# you can use #puts for debugging purposes, e.g.
# #puts "this is a debug message"

$vacations = []

def solution(a)
	calc_vacations(a,false)
	for i in 0..a.length-1
		a[i] = (a[i] == 0) ? 1 : 0
	end
	for i in 0..(a.length-1)/2
		tmp = a[i]
		a[i] = a[a.length - 1 - i]
		a[a.length - 1 - i] = tmp
	end
	calc_vacations(a,true)

	max_vacation = 0
	$vacations.each do |v|
		if max_vacation < v[:end] - v[:start] + 1
			max_vacation =  v[:end] - v[:start] + 1
		end
	end
	return max_vacation
end

def calc_vacations(a, is_calc_end)
	#puts "input #{a}"

	zero_count_cumulative = []
	zero_count = 0
	i = a.length - 1
	while i >= 0
		if a[i] == 0
			zero_count += 1
		else
			zero_count -= 1
		end
		i -= 1
		zero_count_cumulative.unshift zero_count
	end
	#puts "zero_count_cumulative #{zero_count_cumulative}"	

	prev_start_val = -1 * a.length
	prev_start_pos = 0

	i = 0 
	count = (is_calc_end) ? $vacations.length - 1 : 0

	while i < a.length - 1
	  if a[i] == 0 and a[i+1] == 1

		  if zero_count_cumulative[i] < prev_start_val #move left
			  for j in 0..prev_start_pos
				  if zero_count_cumulative[j] >= zero_count_cumulative[i]
					  start = j
					  break
				  end
			  end
		  elsif zero_count_cumulative[i] > prev_start_val #move right
			  for j in prev_start_pos..i
				  if zero_count_cumulative[j] >= zero_count_cumulative[i]
					  start = j
					  break
				  end
			  end
		  else 
			  start = prev_start_pos
		  end

		  prev_start_pos = start
		  prev_start_val = zero_count_cumulative[start]
		  
		  if is_calc_end
			  $vacations[count][:end] =  a.length - 1 - start
		  else
			  $vacations << {start: start}
		  end
		  
		  if is_calc_end
			  count -= 1
		  else
			  count += 1
		  end			

	  end

	  i+=1 
	end

	#puts "vacations #{$vacations}"

end

#puts solution([0,1,1,0])
