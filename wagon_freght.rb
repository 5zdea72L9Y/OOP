require './company'

class WagonFreght
  include Company
  attr_reader :number, :type, :train, :volume, :available_volume
  VOLUME_MAX = 5000
  def initialize(number, train = nil)
    @number = number
    @type = 'Freght'
    @volume = 0
    @available_volume = VOLUME_MAX
    @train = train
    valid?
  end

  def show_wagon_type
    @type
  end

  def fill_volume(volume)
    return false if @volume + volume > VOLUME_MAX

    @volume += volume
    return false if @available_volume - @volume < 0

    @available_volume -= @volume
    true
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
