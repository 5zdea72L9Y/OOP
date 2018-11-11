class Route
  attr_reader :stations
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_secondary_station(station)
    @stations.insert(-2, station)
  end

  def from
    @stations.first
  end

  def to
    @stations.last
  end

  def delete_secondary_station(station)
    @stations.delete(station)
  end

  def show_stations
    puts 'stations: '
    @stations.each do |station|
      puts station.name
    end
  end
end
