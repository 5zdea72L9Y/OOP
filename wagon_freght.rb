require './company'

class WagonFreght
  include Company
  attr_reader :number, :type, :train, :load_capacity, :available_load_capacity
  def initialize(number, load_capacity, train = nil)
    @number = number
    @type = 'Freght'
    @load_capacity = 0
    @available_load_capacity = load_capacity
    @max_load_capacity = load_capacity
    @train = train
    valid?
  end

  def show_wagon_type
    @type
  end

  def fill_volume(volume)
    validate_volume!(volume)
    @load_capacity += volume
    @available_load_capacity -= @load_capacity
    true
  rescue StandardError
    false
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate_volume!(volume)
    raise if @load_capacity + volume > @max_load_capacity
    raise if @available_load_capacity - @load_capacity < 0o0
  end

  def validate!
    raise 'Номер не может быть меньше 0 или больше 100000' if @number <= 0 || @number > 100_000
  end
end
