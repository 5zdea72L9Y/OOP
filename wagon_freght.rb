require './company'

class WagonFreght
  include Company
  attr_reader :number, :type, :train
  def initialize(number, train = nil)
    @number = number
    @type = 'Freght'
    @train = train
    valid?
  end

  def show_wagon_type
    puts @type
  end

  def show_train_wagon
    puts "Вагон #{@number} принадлежит поезду #{@train.number}" if @train
    puts "Вагон #{@number} не принадлежит поезду" unless @train
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    false if @number <= 0 || @number > 100000
  end
end
