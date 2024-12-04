
class Solution < BaseSolution
  puts "jour-01"

  def initialize(input_mode)
    @input = File.open("jour-01/#{input_mode}.txt", 'r').to_a
  end

  def part1
    parse_input.sum
  end

  def part2
    parse_input({
      "one" => 1,
      "two" => 2,
      "three" => 3,
      "four" => 4,
      "five" => 5,
      "six" => 6,
      "seven" => 7,
      "eight" => 8,
      "nine" => 9
    }).sum
  end

  private

  def parse_input(spelled_numbers = {})
    return @input.each_with_index.map do |line, index|
      (1..9).to_a.each { |i| spelled_numbers[i.to_s] = i }
      digits = []
      spelled_numbers.each do |key, value|
        last_index = -1
        while last_index = line.index(key, last_index + 1)
          digits[last_index] = spelled_numbers[key]
        end
      end

      digits.compact!

      pair = digits.first.to_s + digits.last.to_s

      pair.to_i
    end
  end
end
