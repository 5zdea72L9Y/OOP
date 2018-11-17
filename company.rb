module Company
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    @company = nil
    attr_accessor :company
  end
end
