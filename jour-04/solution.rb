
class Solution < BaseSolution
  puts "jour-04"
  def initialize(input_mode)
    @input = File.open("jour-04/#{input_mode}.txt", 'r').map do |line|
      line.chomp.gsub(/Card\s+\d+:/, "").split("|").map { |numbers| numbers.split(" ").map(&:to_i) }
    end
  end

  def part1
    @input.map do |(winning, mine)|
      matches = winning.count { |number| mine.include?(number) }
      1 << (matches-1)
    end.sum
  end

  def part2
    @part2
  end
end
