class DynamicProgramming
  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
                    0 => [[]],
                    1 => [[1]],
                    2 => [[1, 1], [2]],
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
                  }
    @super_frog_cache = { 1 => {0 => [[]], 1 => [[1]]} }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    ans = blair_nums(n - 1) + blair_nums(n - 2) + (((n - 1)*2)-1)
    @blair_cache[n] = ans
    ans
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
              0 => [[]],
              1 => [[1]],
              2 => [[1, 1], [2]],
              3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
            }
    return cache if n < 4
    return cache if n > 11
    (4..n).each do |i|
      step1 = cache[i - 1].map do |ele|
        ele + [1]
      end
      step2 = cache[i - 2].map do |ele|
        ele + [2]
      end
      step3 = cache[i - 3].map do |ele|
        ele + [3]
      end
      cache[i] = step1 + step2 + step3
    end
    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)
    if @super_frog_cache[k].nil?
      @super_frog_cache[k] = {
                              0 => [[]],
                              1 => [[1]]
                            }
    end
    return @super_frog_cache[k][n] unless @super_frog_cache[k][n].nil?
    ans = []
    k = n < k ? n : k
    (1..k).each do |idx|
      ans += super_frog_hops(n - idx, k).map { |el| el + [idx] }
    end
    @super_frog_cache[k][n] = ans
    ans
  end

  # def make_change(amt, coins)
  #   return [] if amt == 0
  #   return nil if coins.none? { |coin| coin <= amt }
  #
  #   coins = coins.sort.reverse
  #
  #   best_change = nil
  #   coins.each_with_index do |coin, index|
  #     next if coin > amt
  #     remainder = amt - coin
  #
  #     best_remainder = make_change(remainder, coins.drop(index))
  #     next if best_remainder.nil?
  #
  #     this_change = [coin] + best_remainder
  #     if (best_change.nil? || (this_change.count < best_change.count))
  #       best_change = this_change
  #     end
  #   end
  #
  #   best_change = best_change ? best_change.sort : nil
  # end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    table[weights.length][capacity]
  end

  def knapsack_table(weights, values, capacity)
    weight_length = weights.length
    weight_values = {}

    (1..weight_length).each do |i|
      weight_values[i] = [weights[i - 1], values[i - 1]]
    end
    table = Array.new(weight_length + 1) { Array.new(capacity + 1)}
    table[0].each_index do |idx|
      table[0][idx] = 0
    end
    (1..weight_length).each do |i|
      weight, value = weight_values[i]
      (capacity+1).times do |j|
        if weight > j
          table[i][j] = table[i-1][j]
        else
          table[i][j] = [table[i-1][j], table[i-1][j - weight] + value].max
        end
      end
    end
    return table
  end

  def populate_knapsack_table()
  end

  def maze_solver(maze, start_pos, end_pos)
    populate_maze(maze)
    solve_maze(maze, start_pos, end_pos)
    @maze_cache[end_pos[0]][end_pos[1]]
  end

  private

  def populate_maze(maze)
    maze.each_with_index do |column, i|
      @maze_cache[i] = {}
      column.each_with_index do |row, j|
        if row == ' ' || row == 'F'
          @maze_cache[i][j] = []
        elsif row == 'S'
          @maze_cache[i][j] = [[i, j]]
        else
          @maze_cache[i][j] = nil
        end
      end
    end
  end

  def solve_maze(maze, start_pos, finish_pos)
    return nil if start_pos[0] < 0 || start_pos[1] >= maze.length
    return nil if start_pos[1] < 0 || start_pos[1] >= maze[0].length
    return nil unless @maze_cache[start_pos[0]][start_pos[1]]
    return @maze_cache unless @maze_cache[finish_pos[0]][finish_pos[1]].empty?
    if @maze_cache[start_pos[0]][start_pos[1]].empty?
      @maze_cache[start_pos[0]][start_pos[1]] = [start_pos]
      return [start_pos]
    end
    @maze_cache.each do |keyi, column|
      column.each do |keyj, row|
        @maze_cache[keyi+1][keyj] += [start_pos] + [keyi+1, keyj] if solve_maze(maze, [keyi+1, keyj], finish_pos)
        @maze_cache[keyi][keyj+1] += [start_pos] + [keyi, keyj+1] if solve_maze(maze, [keyi, keyj+1], finish_pos)
        @maze_cache[keyi-1][keyj] += [start_pos] + [keyi-1, keyj] if solve_maze(maze, [keyi-1, keyj], finish_pos)
        @maze_cache[keyi][keyj-1] += [start_pos] + [keyi, keyj-1] if solve_maze(maze, [keyi, keyj-1], finish_pos)
      end
    end
    @maze_cache
  end
end
