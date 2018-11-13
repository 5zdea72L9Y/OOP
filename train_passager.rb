class TrainPassager < Train
  def initialize(number, wagons)
    type = 'Passager'
    super(number, type, wagons)
  end
end
