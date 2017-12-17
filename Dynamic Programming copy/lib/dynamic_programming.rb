class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    
    ans = blair_nums(n - 1) + blair_nums(n - 2) + (((n - 1)*2)-1)
    @blair_cache[n] = ans
    ans
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
    @frog_cache[n]
  end

  def frog_cache_builder(n)
    return @frog_cache if n < 4
    
    (4..n).each do |i|
      step1 = @frog_cache[i - 1].map do |arr|
        arr + [1]
      end
      
      step2 = @frog_cache[i - 2].map do |arr|
        arr + [2]
      end
      
      step3 = @frog_cache[i - 3].map do |arr|
        arr + [3]
      end
      
      @frog_cache[i] = step1 + step2 + step3
    end
    
    @frog_cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    step1 = frog_hops_top_down_helper(n-1).map do |arr|
      arr + [1]
    end
    
    step2 = frog_hops_top_down_helper(n-2).map do |arr|
      arr + [2]
    end
    
    step3 = frog_hops_top_down_helper(n-3).map do |arr|
      arr + [3]
    end
    
    @frog_cache[n] = step1 + step2 + step3
    @frog_cache[n]
  end

  def super_frog_hops(n, k)
    # number of stairs
    # max stairs a frog can jump
    
    return @frog_cache[n] if @frog_cache[n]
    
    i = 1
    while i < k && n <= k
    end
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0
    table = knapsack_table(weights, values, capacity)
    table.last[capacity]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = Array.new(weights.length) {Array.new(capacity + 1, 0)}
    
    table.each_index do |weight_idx|
      wt = weights[weight_idx]
      val = values[weight_idx]
      
      table[weight_idx].each_index do |curr_capacity|
        next if curr_capacity == 0
        
        if weight_idx == 0 #sets first row
          table[weight_idx][curr_capacity] = (curr_capacity >= wt ? val : 0)
        else        
          cap_diff = (curr_capacity - wt >= 0 ? curr_capacity - wt : 0) #account for if capacity is smaller than weight
          calc_val = val + table[weight_idx - 1][cap_diff]
          prev_val = table[weight_idx - 1][curr_capacity]
          
          table[weight_idx][curr_capacity] = [calc_val, prev_val].max
        end
      end
    end
    
    p table
  end

  def maze_solver(maze, start_pos, end_pos)
    routes = Array.new(maze.length) {Array.new(maze[0].length, 0)}
    
    routes[start_pos[0]][start_pos[1]] = 1
    
    routes.each_index do |col|
      routes[0].each_index do |row|
        scol, srow = start_pos
        if routes[col][row] == 'X' || (scol > col && srow > row)
          routes[col][row] = 0
        else
          prev_routes = routes[col-1][row] + routes[col][row-1]
          routes[col][row] += prev_routes
        end
      end
    end
    p routes[end_pos[0]][end_pos[1]]
  end
end


# table = Array.new(weights.length) {Array.new(capacity + 1, 0)}
# 
# table.each_with_index do |curr_weight_arr, curr_weight_idx|
#   curr_weight_arr.each_index do |total_cap|
#     next if total_cap == 0
# 
#     weight = weights[curr_weight_idx]
#     value = values[curr_weight_idx]
#     prev_value = table[curr_weight_idx][total_cap - 1]
#     if weight > total_cap
#       table[curr_weight_idx][total_cap] = prev_value
#     else
#       weight_diff = total_cap - weight
#       diff = table[weight_diff][total_cap - 1]
# 
#       max_cal_value = diff + value
#       table[curr_weight_idx][total_cap] = (prev_value > max_cal_value ? prev_value : max_cal_value)
#     end
#   end
# end
# 
# table