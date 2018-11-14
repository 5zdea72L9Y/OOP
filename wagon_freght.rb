class WagonFreght
  attr_reader :number, :type, :train
  def initialize(number, train = nil)
    @number = number
    @type = 'Freght'
    @train = train
  end

  def show_wagon_type
    puts @type
  end

  def show_train_wagon
    puts "Вагон #{@number} принадлежит поезду #{@train.number}" if @train
    puts "Вагон #{@number} не принадлежит поезду" unless @train
  end
end
