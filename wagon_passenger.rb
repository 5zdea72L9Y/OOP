require './company'

class WagonPassenger
  include Company
  attr_reader :number, :type, :train, :places, :freedom_places, :busy_places
  def initialize(number, train = nil)
    @number = number
    @type = 'Passenger'
    @places = {}
    32.times do
      count = 0

      loop do
        @places[count] = true
        count += 1
        break if count == 32
      end
    end
    @freedom_places = @places.select { |_key, val| val == true }
    @busy_places = @places.select { |_key, val| val == false }
    @train = train
    valid?
  end

  def show_freedom_places
    @freedom_places.each_key do |key|
      puts "Номер: #{key}"
    end
  end

  def show_busy_places
    @busy_places.each_key do |key|
      puts "Номер: #{key}"
    end
  end

  def get_place(number)
    return unless @freedom_places.key?(number)

    @places[number] = false
    @freedom_places = @places.select { |_key, val| val == true }
    @busy_places = @places.select { |_key, val| val == false }
    true
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
