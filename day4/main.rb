input = File.open("input.txt")

matrix = []
input.each { |line| matrix << line.strip.split("") }

n = matrix.size
m = matrix.first.size

positions = Array.new(m) { Array.new(n) { 0 } }
result_matrix = Array.new(m) { Array.new(n) { "." } }

word = "XMAS"
len_word = word.size

match_count = 0
(0...n).each do |i|
  (0...m).each do |j|
    next unless matrix[i][j] == "X" || matrix[i][j] == "S"
    if i + len_word <= m
      match = (0...len_word).each_with_object([]) { |l, match|  match << matrix[i+l][j] }.join
      if match == word || match == word.reverse
        match_count += 1
        (0...len_word).each do |l|
          positions[i+l][j] = 1
        end
      end
    end
    if j + len_word <= n
      match = (0...len_word).each_with_object([]) { |l, match|  match << matrix[i][j+l] }.join
      if match == word || match == word.reverse
        match_count += 1
        (0...len_word).each do |l|
          positions[i][j+l] = 1
        end
      end
    end
    if j + len_word <= n && i + len_word <= m
      match = (0...len_word).each_with_object([]) { |l, match|  match << matrix[i+l][j+l] }.join
      if match == word || match == word.reverse
        match_count += 1
        (0...len_word).each do |l|
          positions[i+l][j+l] = 1
        end
      end
    end
    if i - len_word + 1 >= 0 && j + len_word <= n
      match = (0...len_word).each_with_object([]) { |l, match|  match << matrix[i-l][j+l] }.join
      if match == word || match == word.reverse
        match_count += 1
        (0...len_word).each do |l|
          positions[i-l][j+l] = 1
        end
      end
    end
  end
end

# For printing the result string
(0...n).each do |i|
  (0...m).each do |j|
    result_matrix[i][j] = matrix[i][j] if positions[i][j] == 1
  end
end

joined_input = result_matrix.map { |el| el.join }.join "\n"

puts "match count : #{match_count} "
puts "----------"
puts "Result matrix : "
puts joined_input


# Part 2
x_mas_count = 0
(1...n-1).each do |i|
  (1...m-1).each do |j|
    lt = matrix[i-1][j-1]
    rt = matrix[i-1][j+1]
    lb = matrix[i+1][j-1]
    rb = matrix[i+1][j+1]
    if matrix[i][j] == "A" && ((lt == "M" && rb == "S") || (lt == "S" && rb == "M")) && ((rt == "M" && lb == "S") || (rt == "S" && lb == "M"))
      x_mas_count += 1
    end
  end
end

puts "X mas count : #{x_mas_count} "
