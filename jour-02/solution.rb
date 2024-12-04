
class Solution < BaseSolution
  puts "jour-02"
  def initialize(input_mode)
    @input = File.open("jour-02/#{input_mode}.txt", 'r').to_a

    @games = @input.map { |line| parse_game(line) }
  end

  def part1
    @games.select{ |game| enough_colors?(game) }.map{ |game| game[:id] }.sum
  end

  def part2
    @games.map { |game| game[:blue] * game[:green] * game[:red] }.sum
  end

  private

  def parse_game(line)
    game = {}
    game[:id] = line.scan(/Game (\d+): /).flatten.first.to_i
    game[:blue] = line.scan(/(\d+) blue/).flatten.map(&:to_i).sort.last
    game[:green] = line.scan(/(\d+) green/).flatten.map(&:to_i).sort.last
    game[:red] = line.scan(/(\d+) red/).flatten.map(&:to_i).sort.last
    return game
  end

  def enough_colors?(game)
    return false if game[:red] > 12
    return false if game[:green] > 13
    return false if game[:blue] > 14
    true
  end
end
