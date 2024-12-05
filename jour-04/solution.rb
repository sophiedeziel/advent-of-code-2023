
class Solution < BaseSolution
  puts "jour-04"
  def initialize(input_mode)
    @input = File.open("jour-04/#{input_mode}.txt", 'r').map do |line|
      line.chomp.gsub(/Card\s+\d+:/, "").split("|").map { |numbers| numbers.split(" ").map(&:to_i) }
    end

    @wins = @input.map do |(winning, mine)|
      matches = winning.count { |number| mine.include?(number) }
    end
  end

  def part1
    @wins.map { |n| 1 << (n-1) }.sum
  end

  def part2
    @wins.each_with_index.each_with_object({}) do |(wins, index), counts|
      counts[index + 1] ||= 1
      wins.times do |i|
        counts[index + i + 2] ||= 1
        counts[index + i + 2] += counts[index + 1]
      end
    end.values.sum
  end
end
