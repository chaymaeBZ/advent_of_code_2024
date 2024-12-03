input = File.open("input.txt").read.to_s

numbers = input.scan /mul\((\d+),(\d+)\)/
sum = 0

numbers.each { |l, r| sum += l.to_i * r.to_i }

p "Instructions result is : #{sum}"

sum = 0
instructions = input.scan /mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))/

apply = true
instructions.each do |l, r, ins_do, ins_dont|
  apply = false if ins_dont
  apply = true if ins_do

  sum += l.to_i * r.to_i if apply
end

p "Part 2 Instructions result is : #{sum}"
