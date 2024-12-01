input = File.open("input.txt")

# part 1
first_list = []
second_list = []
input.each do |line|
  # split is faster to run than scan
  left, right = line.split("\s")

  first_list << left
  second_list << right
end

first_list.sort!
second_list.sort!

locations_count = first_list.size

distance = 0
(0...locations_count).each do |i|
  distance += (second_list[i].to_i - first_list[i].to_i).abs
end

p "the distance is : #{distance}"

# part 2
similarity_score = 0
first_list.each do |element|
  similarity_score += element.to_i * second_list.count(element)
end

p "similarity score is: #{similarity_score}"
