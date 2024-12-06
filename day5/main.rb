rules_input = File.open("rules.txt")

rules = rules_input.each_with_object(Hash.new { |h, k| h[k] = []}) do |rule, h|
  k, v = rule.strip.split "|"
  h[k] << v
end

updates_input = File.open("input.txt")

valid_updates = []
updates = []

updates_input.each do |update|
  updates << update.strip.split(",")
end


updates.each do |update|
  valid = true
  update.each_with_index do |page_before, index|
    update[index+1..-1].each do |page_after|
      if rules[page_after].include? page_before
        valid = false
      end
    end
  end

  valid_updates << update if valid
end

sum = 0
valid_updates.each do |up|
  sum += up[up.size/2].to_i
end

p "Sum of valid updates: #{sum}"

invalid_updates = updates - valid_updates
new_valid_updates = []


invalid_updates.each do |update|
  update.each_with_index do |page_before, index_before|
    update[index_before+1..-1].each_with_index do |page_after, index_padding|
      if rules[page_after].include? page_before
        update[index_before] = page_after
        update[index_before + index_padding + 1] = page_before
        page_after = page_before
        page_before = update[index_before]
      end
    end
  end
end

sum2 = 0
invalid_updates.each do |up|
  sum2 += up[up.size/2].to_i
end

p "Sum of new valid updates: #{sum2}"
