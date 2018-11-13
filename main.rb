require './station'
require './route'
require './train'
require './train_passager'
require './train_freght'

@custom_stations = []
@custom_trains = []
@custom_routes = []

def create_station
  puts 'Введите имя станции: '
  custom_station_name = gets.chomp

  custom_station = Station.new(custom_station_name)
  puts 'Станция создана'
  @custom_stations << custom_station
end

def create_train
  puts "Введите тип поезда: \n
    1 - Passager \n
    2 - Freght
  "
  type = gets.chomp.to_i

  puts 'Введите номер поезда: '
  number = gets.chomp.to_i

  puts 'Введите кол-во вагонов: '
  wagons = gets.chomp.to_i

  case type
  when 1
    custom_train = TrainPassager.new(number, wagons)
    @custom_trains << custom_train
    puts 'Поезд успешно создан'
  when 2
    custom_train = TrainFreght.new(number, wagons)
    @custom_trains << custom_train
    puts 'Поезд успешно создан'
  else
    puts 'Неправильный тип поезда'
  end
end

def create_route
  puts 'Введите начальную станцию: '

  get_custom_stations

  custom_route_first = gets.chomp.to_i

  puts 'Введите последнюю станцию: '
  custom_route_last = gets.chomp.to_i

  custom_station1 = find_station_in_custom_stations(custom_route_first)
  custom_station2 = find_station_in_custom_stations(custom_route_last)

  create_route = Route.new(custom_station1, custom_station2)
  @custom_routes << create_route
  puts 'Маршрут успешно создан'
end

def add_route_to_train
  puts 'Введите номер поезда: '

  get_custom_trains

  train_number = gets.chomp.to_i

  puts 'Введите маршрут: '

  get_custom_routes

  route_number = gets.chomp.to_i

  find_route = find_route_in_custom_routes(route_number)
  find_train = find_train_in_custom_trains(train_number)

  find_train.add_route(find_route)
  puts 'Маршрут успешно добавлен'
end

def add_wagon_to_train
  puts 'Введите номер поезда: '

  get_custom_trains

  train_number = gets.chomp.to_i

  find_train = find_train_in_custom_trains(train_number)

  find_train.add_wagon
end

def delete_wagon_from_train
  puts 'Введите номер поезда: '

  get_custom_trains

  train_number = gets.chomp.to_i

  find_train = find_train_in_custom_trains(train_number)

  find_train.delete_wagon
end

def move_train
  puts 'Введите номер поезда: '

  get_custom_trains

  train_number = gets.chomp.to_i

  find_train = find_train_in_custom_trains(train_number)

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

  get_custom_stations

  station_number = gets.chomp.to_i

  find_station = find_station_in_custom_stations(station_number)

  find_station.show_trains
end

def check_train_route
  puts 'Введите номер поезда: '

  get_custom_trains

  train_number = gets.chomp.to_i

  find_train = find_train_in_custom_trains(train_number)

  puts 'Маршрут выбранного поезда: '

  find_train.show_route

  puts "Текущая станция: #{find_train.current_station.name}"
end

def add_or_remove_speed
  puts 'Введите номер поезда: '

  get_custom_trains

  train_number = gets.chomp.to_i

  find_train = find_train_in_custom_trains(train_number)

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

def get_custom_trains
  @custom_trains.each_with_index do |train, i|
    puts "#{i} - #{train.number}, #{train.type}, #{train.wagons.count}"
  end
end

def get_custom_stations
  @custom_stations.each_with_index do |station, i|
    puts "#{i} - #{station.name}"
  end
end

def get_custom_routes
  @custom_routes.each_with_index do |route, i|
    puts "#{i} - #{route.stations.each(&:name)}"
  end
end

def find_train_in_custom_trains(train_i)
  @custom_trains[train_i]
end

def find_route_in_custom_routes(route_i)
  @custom_routes[route_i]
end

def find_station_in_custom_stations(station_i)
  @custom_stations[station_i]
end

loop do
  puts "Введите номер \n
  1 - Создать станцию \n
  2 - Создать поезд \n
  3 - Добавить маршрут \n
  4 - Назначить маршрут поезду \n
  5 - Добавить вагон поезду \n
  6 - Убрать вагон поезда \n
  7 - Переместить поезд по маршруту \n
  8 - Список поездов на станции \n
  9 - Посмотреть маршрут поезда \n
  10 - Убавить или добавить скорость \n
  0 - exit
  "
  action = gets.chomp.to_i

  case action
  when 0
    break
  when 1
    create_station
  when 2
    create_train
  when 3
    create_route
  when 4
    add_route_to_train
  when 5
    add_wagon_to_train
  when 6
    delete_wagon_from_train
  when 7
    move_train
  when 8
    trains_on_station
  when 9
    check_train_route
  when 10
    add_or_remove_speed
  end
end

# station_first = Station.new('ggg')
# station_last_ru = Station.new('fff')
# station_last_en = Station.new('rrr')
# station_test = Station.new('test')
#
# route_passager = Route.new(station_first, station_last_ru)
# route_freght = Route.new(station_first, station_last_en)
#
# train_passager = TrainPassager.new(1, 16)
# train_freght = TrainFreght.new(2, 33)
#
# train_passager.add_route(route_passager)
# train_freght.add_route(route_freght)
#
# puts "Train: #{train_passager.number}, route: #{train_passager.show_route}"
# puts "Train: #{train_freght.number}, route: #{train_freght.show_route}"
#
#
# p station_first.show_trains
#
# station_first.get_trains_by_type('Passager')
#
# 5.times do
#   train_passager.delete_wagon
# end
