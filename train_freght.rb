class TrainFreght < Train
  require './instance_counter'
  include InstanceCounter
  def initialize(number)
    type = 'Freght'
    super(number, type)
  end

  def add_wagon(wagon)
    return false if wagon.type == 'Passenger'

    super(wagon)
  end
end
