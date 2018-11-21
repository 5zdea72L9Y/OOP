class Station
  require './instance_counter'
  include InstanceCounter
  attr_reader :name
  @@all_stations = []
  def initialize(name)
    @name = name.to_s
    valid?
    @trains = []
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
      puts "Номер поезда: #{train.number}, тип поезда: #{train.type}, вагоны поезда: #{train.wagons}"
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    regexp = /^[a-z]{3,50}$/i
    raise 'Имя не может быть меньше 3 или больше 50 символов' unless @name =~ regexp
  end
end
