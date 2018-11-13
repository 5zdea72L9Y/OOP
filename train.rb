class Train
  attr_reader :speed, :type, :wagons, :number, :route

  def initialize(number, type, wagons)
    @number = number
    @wagons = (1..wagons).to_a
    @type = type
    @speed = 0
    @route = nil
    @current_station = 0
  end

  def add_speed(speed)
    @speed += speed
  end

  def remove_speed(speed)
    if @speed - speed > 0
      @speed -= speed
    else
      puts 'Скорость не может быть отрицательной'
    end
  end

  def add_wagon # если поезд пассажирский то вагоны все будут пассажирские. Знаю что очевидно, но это для понимания моей реализации
    return puts 'Сбавьте скорость до 0' unless @speed.zero?

    @wagons << @wagons.count + 1
  end

  def delete_wagon
    return puts 'Сбавьте скорость до 0' unless @speed.zero?
    return puts 'Кол-во вагонов не может быть отрицательным' if @wagons.empty?

    @wagons.delete(@wagons.count)
  end

  def add_route(route)
    @route = route
    @route.from.accept_train(self)
  end

  def show_route
    puts @route.show_stations
  end

  def move_straight
    return puts 'Станций больше нет' unless next_station
    return puts 'Скорость равна 0' if @speed.zero?

    current_station.delete_train(self)
    @current_station += 1
    current_station.accept_train(self)
  end

  def move_back
    return puts 'Станций больше нет' unless prev_station
    return puts 'Скорость равна 0' if @speed.zero?

    current_station.delete_train(self)
    @current_station -= 1
    current_station.accept_train(self)
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def prev_station
    @route.stations[@current_station - 1] unless @current_station.zero?
  end

  def stop
    @speed = 0
  end

  def current_station
    @route.stations[@current_station]
  end
end
