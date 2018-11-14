class TrainPassenger < Train
  def initialize(number)
    type = 'Passenger'
    super(number, type)
  end

  def add_wagon(wagon)
    return puts 'Нельзя на пассажирский поезд прицепить грузовой вагон' if wagon.type == 'Freght'
    super(wagon)
  end

end
