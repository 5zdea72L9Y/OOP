module Company
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def show_trains_passenger_company
      'MyPassengerTrainsCompany'
    end

    def show_trains_freght_company
      'MyFreghtTrainsCompany'
    end

    def show_wagons_passenger_company
      'MyPassengerWagonsCompany'
    end

    def show_wagons_freght_company
      'MyFreghtWagonsCompany'
    end
  end
end
