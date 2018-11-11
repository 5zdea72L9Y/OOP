class Station
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
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
      puts "Train number: #{train.number}, train type: #{train.type}, train wagons: #{train.wagons}"
    end
  end
end
