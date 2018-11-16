class TrainFreght < Train
  require './instance_counter'
  include InstanceCounter
  def initialize(number)
    type = 'Freght'
    super(number, type)
  end

  def add_wagon(wagon)
    return puts 'Нельзя на грузовой поезд прицепить пассажирский вагон' if wagon.type == 'Passenger'

    super(wagon)
  end
end
