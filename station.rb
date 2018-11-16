class Station
  require './instance_counter'
  include InstanceCounter
  attr_reader :name
  @@all_stations = []
  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def self.all_stations
    @@all_stations.each_with_index do |station, i|
      puts "#{i} - #{station}"
    end
  end

  def accept_train(train)
    @trains << train
  end

  def get_trains_by_type(type)
    sort_trains = @trains.select { |train| train.type == type }
    sort_trains.each do |train|
      puts "#{type} trains: "
      puts train.number
    end
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def show_trains
    @trains.each do |train|
      puts "Номер поезда: #{train.number}, тип поезда: #{train.type}, вагоны поезда: #{train.wagons}"
    end
  end
end
