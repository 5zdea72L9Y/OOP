class TrainPassenger < Train
  require './instance_counter'
  include InstanceCounter
  def initialize(number)
    type = 'Passenger'
    super(number, type)
  end

  def add_wagon(wagon)
    return false if wagon.type == 'Freght'

    super(wagon)
  end
end
