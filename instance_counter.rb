module InstanceCounter
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    private

    attr_writer :instances

    def add_instance
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances
      self.class.send :add_instance
    end
  end
end
