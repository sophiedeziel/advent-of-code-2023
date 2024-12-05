
class Solution < BaseSolution
  puts "jour-05"
  def initialize(input_mode)
    @input = parse_almanac(File.open("jour-05/#{input_mode}.txt", 'r').read)
  end

  def part1
    @part1 = @seeds.map do |seed|
      soil = get_destination(seed, @input[:seed_to_soil])
      fertilizer = get_destination(soil, @input[:soil_to_fertilizer])
      water = get_destination(fertilizer, @input[:fertilizer_to_water])
      light = get_destination(water, @input[:water_to_light])
      temperature = get_destination(light, @input[:light_to_temperature])
      humidity = get_destination(temperature, @input[:temperature_to_humidity])
      location = get_destination(humidity, @input[:humidity_to_location])
    end.sort.first
    # @input
  end

  def part2
    @part2
  end

  private

  def parse_almanac(input)
    lines = input.split("\n").map(&:chomp)

    @seeds = lines.first.scan(/\d+/).map(&:to_i)

    results = { }

    types = {
      "soil-to-fertilizer map:" => :soil_to_fertilizer,
      "fertilizer-to-water map:" => :fertilizer_to_water,
      "water-to-light map:" => :water_to_light,
      "light-to-temperature map:" => :light_to_temperature,
      "temperature-to-humidity map:" => :temperature_to_humidity,
      "humidity-to-location map:" => :humidity_to_location,
    }
    parsing = nil
    lines.each do |line|
      next if line.empty?
      if parsing == nil
        next unless line == "seed-to-soil map:"
        parsing = :seed_to_soil
        next
      end

      if types.keys.include? line
        parsing = types[line]
        next
      end

      numbers = line.scan(/\d+/).map(&:to_i), results[parsing]
      next if numbers.nil?
      results[parsing] ||= []
      results[parsing] << numbers.first
    end
    results
  end

  def get_destination(source, maps)
    map = maps.find do |(d, s, r)|
      source.between?(s, s + r)
    end
    return source if map.nil?
    offset = source - map[1]

    map[0] + offset
  end
end
