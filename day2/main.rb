input = File.open("input.txt")

# Prepare data
reports = []
input.each do |line|
  report = line.split(" ").map(&:to_i)
  reports << report
end

# Part 1
#
def all_decreasing?(report)
  report.each_cons(2).all? { |el1, el2| el1 - el2 >= 1 && el1 - el2 <= 3 }
end

def all_increasing?(report)
  report.each_cons(2).all? { |el1, el2| el2 - el1 >= 1 && el2 - el1 <= 3 }
end

safe_reports = 0
reports.each do |report|
  safe_reports += 1 if all_decreasing?(report) || all_increasing?(report)
end

p "#{safe_reports} reports are safe"

# Part 2
safe_reports_minus_level = 0
reports.each do |report|
  safe_reports_minus_level += 1 if report.each_index.any? do |index|
    report_minus_level = report[0...index] + report[(index+1)..-1]
    all_increasing?(report_minus_level) || all_decreasing?(report_minus_level)
  end

end

p "#{safe_reports_minus_level} reports are safe (minus level)"
