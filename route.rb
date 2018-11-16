class Route
  require './instance_counter'
  include InstanceCounter
  attr_reader :stations
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_secondary_station(station)
    @stations.insert(-2, station)
  end

  def delete_secondary_station(station)
    @stations.delete(station)
  end

  def show_stations
    puts 'Станции: '
    @stations.each do |station|
      puts station.name
    end
  end

  def from
    @stations.first
  end

  def to
    @stations.last
  end
end
