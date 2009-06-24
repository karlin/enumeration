module Enumeration
  def self.of(*values)
    if values[0].is_a? Array
      values = values[0]
    end
    order = (0...values.size).to_a
    values = values.map {|v| v.to_s }
    klass = Module.new
    values.each do |value|
      const_name = value.upcase
      klass.const_set const_name, value.freeze
    end
    klass.extend Enumeration
    
    order = order.inject({}) do |hash, value|
      hash[values.shift] = value
      hash
    end.freeze
    klass.const_set :Order, order.freeze
    klass.freeze
    klass
  end
  
  def enum
    self.const_get(:Order).keys.sort_by {|x| self.const_get(:Order)[x]}
  end
  
end
