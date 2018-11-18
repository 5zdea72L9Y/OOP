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

  private 

  def valid?
    raise 'Введен невалидный номер вагона' if @number <= 0
    raise 'Номер вагона не может быть больше 1000' if @number > 100000
    true
  end
end
