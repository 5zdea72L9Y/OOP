class Station
  require './instance_counter'
  require './validation'
  include InstanceCounter
  include Validation
  attr_reader :name

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /^[a-z]{3,50}$/i

  @@all_stations = []
  def initialize(name)
    @name = name.to_s
    @trains = []
    validate!
    @@all_stations << self
    register_instance
  end

  def self.all_stations
    @@all_stations
  end

  def accept_train(train)
    @trains << train
  end

  def get_trains_by_type(type)
    sort_trains = @trains.select { |train| train.type == type }
    puts "#{type} trains: "
    sort_trains.each do |train|
      puts train.number
    end
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def show_trains
    @trains.each do |train|
      puts "Номер поезда: #{train.number},
      тип поезда: #{train.type},
      вагоны поезда: #{train.wagons}
      "
    end
  end

  def each_trains_block
    @trains.each do |train|
      yield(train)
    end
  end
end
