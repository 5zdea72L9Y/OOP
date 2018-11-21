require './company'

class WagonPassenger
  include Company
  attr_reader :number, :type, :train
  def initialize(number, train = nil)
    @number = number
    @type = 'Passenger'
    @train = train
    valid?
  end

  def show_wagon_type
    @type
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Номер не может быть меньше 0 или больше 100000' if @number <= 0 || @number > 100_000
  end
end
