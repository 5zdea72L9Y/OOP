require './station'
require './route'
require './train'
require './train_passenger'
require './train_freght'
require './wagon_freght'
require './wagon_passenger'

class Main
  def initialize
    @custom_stations = []
    @custom_trains = []
    @custom_routes = []
    @custom_wagons = []
  end

  def start_program
    loop do
      puts "Введите номер \n
      1 - Создать станцию \n
      2 - Создать вагон \n
      3 - Создать поезд \n
      4 - Добавить маршрут \n
      5 - Назначить маршрут поезду \n
      6 - Добавить вагон поезду \n
      7 - Убрать вагон поезда \n
      8 - Переместить поезд по маршруту \n
      9 - Список поездов на станции \n
      10 - Посмотреть маршрут поезда \n
      11 - Убавить или добавить скорость \n
      12 - Показать вагоны поезда \n
      13 - Показать или указать производителя поездов и вагонов \n
      14 - Показать все станции \n
      15 - Найти поезд по номеру \n
      16 - Показать количество экземпляров класса \n
      0 - exit
      "
      action = gets.chomp.to_i
      main = Main.new
      case action
      when 0
        break
      when 1
        create_station
      when 2
        create_wagon
      when 3
        create_train
      when 4
        create_route
      when 5
        add_route_to_train
      when 6
        add_wagon_to_train
      when 7
        delete_wagon_from_train
      when 8
        move_train
      when 9
        trains_on_station
      when 10
        check_train_route
      when 11
        add_or_remove_speed
      when 12
        show_train_wagons
      when 13
        show_or_set_company
      when 14
        show_all_stations
      when 15
        show_train_by_number
      when 16
        show_intialize_count
      end
    end
  end

  private

  def show_intialize_count
    puts "Роуты: #{Route.instances}, поезда: #{TrainPassenger.instances + TrainFreght.instances}, станции: #{Station.instances}"
  end

  def show_or_set_company
    puts "Выберите действие:
      1 - указать производителя вагонов
      2 - указать производителя поездов
      3 - показать производителя вагонов
      4 - показать производителя поездов
    "
    action = gets.chomp.to_i

    case action
    when 1
      puts 'Введите производителя: '
      company_name = gets.chomp
      WagonFreght.company = company_name
      WagonPassenger.company = company_name
    when 2
      puts 'Введите производителя: '
      company_name = gets.chomp
      Train.company = company_name
    when 3
      puts WagonFreght.company # или WagonPassenger.company
    when 4
      puts Train.company
    end
  end

  def show_all_stations
    puts Station.all_stations
  end

  def show_train_by_number
    puts 'Введите номер поезда: '
    train_number = gets.chomp.to_i
    puts Train.find(train_number)
  end

  def create_station
    puts 'Введите имя станции: '
    custom_station_name = gets.chomp
    custom_station = Station.new(custom_station_name)
    puts 'Станция создана'
    @custom_stations << custom_station
  end

  def create_train
    puts "Введите тип поезда: \n
    1 - Passenger \n
      2 - Freght
    "
    type = gets.chomp.to_i
    puts 'Введите номер поезда: '
    number = gets.chomp.to_i
    case type
    when 1
      custom_train = TrainPassenger.new(number)
      @custom_trains << custom_train
      puts 'Поезд успешно создан'
    when 2
      custom_train = TrainFreght.new(number)
      @custom_trains << custom_train
      puts 'Поезд успешно создан'
    else
      puts 'Неправильный тип поезда'
    end
  end

  def create_route
    puts 'Введите начальную станцию: '
    show_stations
    custom_route_first = gets.chomp.to_i
    puts 'Введите последнюю станцию: '
    custom_route_last = gets.chomp.to_i
    custom_station1 = @custom_stations[custom_route_first]
    custom_station2 = @custom_stations[custom_route_last]
    create_route = Route.new(custom_station1, custom_station2)
    @custom_routes << create_route
    puts 'Маршрут успешно создан'
  end

  def add_route_to_train
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    puts 'Введите маршрут: '
    show_routes
    route_number = gets.chomp.to_i
    find_route = @custom_routes[route_number]
    find_train = @custom_trains[train_number]
    find_train.add_route(find_route)
    puts 'Маршрут успешно добавлен'
  end

  def add_wagon_to_train
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    puts 'Введите номер вагона: '
    show_wagons_add
    wagon_number = gets.chomp.to_i
    find_train = @custom_trains[train_number]
    find_wagon = @custom_wagons[wagon_number]
    find_train.add_wagon(find_wagon)
  end

  def delete_wagon_from_train
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    puts 'Введите номер вагона: '
    find_train = @custom_trains[train_number]
    find_train.show_wagons
    wagon_number = gets.chomp.to_i
    find_wagon = @custom_wagons[wagon_number]
    find_train.delete_wagon(find_wagon)
  end

  def move_train
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    find_train = @custom_trains[train_number]
    puts 'Маршрут выбранного поезда: '
    find_train.show_route
    puts "Введите в какую сторону поедет поезд: \n
      1 - straight \n
      2 - back \n
    "
    direction = gets.chomp.to_i
    find_train.move_straight if direction == 1
    find_train.move_back if direction == 2
    find_train.current_station
  end

  def trains_on_station
    puts 'Введите номер станции: '
    show_trains
    station_number = gets.chomp.to_i
    find_station = @custom_stations[station_number]
    find_station.show_trains
  end

  def check_train_route
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    find_train = @custom_trains[train_number]
    puts 'Маршрут выбранного поезда: '
    find_train.show_route
    puts "Текущая станция: #{find_train.current_station.name}"
  end

  def add_or_remove_speed
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    find_train = @custom_trains[train_number]
    puts "текущая скорость: #{find_train.speed}"
    puts "Добавить или убавить скорость: \n
      1 - Добавить \n
      2 - Убавить \n
    "
    speed_action = gets.chomp.to_i
    case speed_action
    when 1
      puts 'Сколько хотите добавить? '
      speed = gets.chomp.to_i
      find_train.add_speed(speed)
    when 2
      puts 'Сколько хотите убавить? '
      speed = gets.chomp.to_i
      find_train.remove_speed(speed)
    end

    puts "текущая скорость: #{find_train.speed}"
  end

  def create_wagon
    puts 'Введите номер вагона: '
    wagon_number = gets.chomp.to_i
    puts "Введите тип вагона:
      1 - Пассажирский \n
      2 - Грузовой
    "
    wagon_type = gets.chomp.to_i
    case wagon_type
    when 1
      passenger_wagon = WagonPassenger.new(wagon_number)
      @custom_wagons << passenger_wagon
      puts 'Вагон успешно добавлен'
    when 2
      freght_wagon = WagonFreght.new(wagon_number)
      @custom_wagons << freght_wagon
      puts 'Вагон успешно добавлен'
    end
  end

  def show_trains
    @custom_trains.each_with_index do |train, i|
      puts "#{i} - #{train.number}, #{train.type}, #{train.wagons.count}"
    end
  end

  def show_stations
    @custom_stations.each_with_index do |station, i|
      puts "#{i} - #{station.name}"
    end
  end

  def show_routes
    @custom_routes.each_with_index do |route, i|
      puts "#{i} - #{route.stations.each(&:name)}"
    end
  end

  def show_wagons_add
    @custom_wagons.each_with_index do |wagon, i|
      puts "#{i} - #{wagon.number}, #{wagon.type}" unless wagon.train
    end
  end

  def show_train_wagons
    puts 'Введите номер поезда: '
    show_trains
    train_number = gets.chomp.to_i
    find_train = @custom_trains[train_number]
    find_train.show_wagons
  end
end

main = Main.new

main.start_program
