class TrainFreght < Train
  def initialize(number, wagons)
    number = number
    wagons = wagons
    type = 'Freght'
    super(number, type, wagons)
  end
end
