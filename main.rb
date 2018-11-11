require './station.rb'
require './route.rb'
require './train.rb'

station_first = Station.new('ggg')
station_last = Station.new('fff')
station_test = Station.new('test')
route = Route.new(station_first, station_last)
train = Train.new(1, 'passager', 16)

train.add_route(route)

puts "Current station for train #{train.number} : #{train.current_station.name}"

train.show_route

train.add_speed(20)
train.move_straight

route.add_secondary_station(station_test)

train.show_route

puts "Current station for train #{train.number} : #{train.current_station.name}"

train.move_back

puts "Current station for train #{train.number} : #{train.current_station.name}"

train.stop
