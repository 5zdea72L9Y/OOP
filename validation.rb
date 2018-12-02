module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def data
      @data ||= []
    end

    def validate(name, type, param = nil)
      raise TypeError unless %i[presence format type].include?(type)

      data << { name: name, type: type, param: param }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    def validate!
      self.class.data.each do |value|
        name = value[:name]
        value_name = instance_variable_get("@#{name}".to_sym)
        send("validate_#{value[:type]}", value_name, value[:param])
      end
    end

    def validate_presence(name, _param)
      raise 'blank или nil' if name.nil? || name.to_s.empty?
    end

    def validate_format(name, format)
      raise 'неправильный формат' unless name =~ format
    end

    def validate_type(name, type)
      raise TypeError unless name.class == type
    end
  end
end