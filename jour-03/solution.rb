class Solution < BaseSolution
  puts "Jour 03"
  puts "======"

  def initialize(input_mode)
    puts input_mode
    puts ""
    @parts = {}
    @numbers = {}
    File.open("jour-03/#{input_mode}.txt", 'r').each_with_index.flat_map do |line, ln|
      line.chomp.each_char.with_index do |char, col|
        if char == '.'
          next
        elsif (0..9).to_a.map(&:to_s).include?(char)
          @numbers[[ln, col]] = merge_number(char, [ln, col]).to_i
        else
          @parts[[ln, col]] = char
        end
      end
    end
  end

  def part1
    @parts.flat_map do |(ln, col), number|
      vectors = [
        [ln - 1, col - 1],
        [ln - 1, col],
        [ln - 1, col + 1],
        [ln, col - 1],
        [ln, col + 1],
        [ln + 1, col - 1],
        [ln + 1, col],
        [ln + 1, col + 1]
      ]

      vectors.map do |(ln, col)|
        @numbers[[ln, col]]
      end.compact.uniq
    end.sum
  end

  def part2
    @parts
      .select { |k, v| v == "*" }
      .map do |(ln, col), number|
        vectors = [
          [ln - 1, col - 1],
          [ln - 1, col],
          [ln - 1, col + 1],
          [ln, col - 1],
          [ln, col + 1],
          [ln + 1, col - 1],
          [ln + 1, col],
          [ln + 1, col + 1]
        ]

        numbers = vectors.map do |(ln, col)|
          @numbers[[ln, col]]
        end.compact.uniq
      end.select do |numbers|
        numbers.count == 2
      end.map do |numbers|
        numbers.inject(:*)
      end.sum
  end

  private

  def merge_number(number, position)
    return number if previous_number(position).nil?
    merge_number(number, [position.first, position.last - 1])
    @numbers[[position.first, position.last - 1]] = (previous_number(position) * 10) + number.to_i
  end

  def previous_number(position)
    @numbers[[position.first, position.last - 1]]
  end
end
