class Train 
  attr_reader :speed
  attr_reader :type
  attr_reader :wagons
  attr_reader :number
  attr_reader :route
  def initialize(number, type, wagons)
    if %w(passager freght).include?(type)
      @number = number.to_i
      @type = type
      @wagons = wagons.to_i
      @speed = 0
      @route = nil
      @current_station = 0
    else 
      puts 'Неправильно указан тип поезда'
    end
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

  def add_wagon
    if @speed.zero?
      @wagons += 1
    else
      puts 'Сбавьте скорость до 0'
    end
  end

  def delete_wagon
    if @speed.zero?
      if @wagons - 1 > 0
        @wagons -= 1
      else 
        puts 'Кол-во вагонов не может быть отрицательным'
      end
    else
      puts 'Сбавьте скорость до 0'
    end
  end

  def add_route(route)
    @route = route
    @route.from.accept_train(self)
  end

  def show_route
    puts @route.show_stations
  end

  def move_straight
    if next_station
      if !@speed.zero?
        current_station.delete_train(self)
        @current_station += 1
        current_station.accept_train(self)
      else 
        puts 'Скорость равна 0'
      end
    else
      puts 'Станций больше нет'
    end
  end

  def move_back 
    if prev_station
      if !@speed.zero?
        current_station.delete_train(self)
        @current_station -= 1
        current_station.accept_train(self)
      else 
        puts 'Скорость равна 0'
      end
    else 
      puts 'Станций больше нет'
    end
  end

  def current_station
    @route.stations[@current_station]
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

end