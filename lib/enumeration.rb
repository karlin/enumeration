# = Enumeration
# 
# Between string and symbol array literals, hash literals, and constants in
# modules or classes, Ruby users have plenty of options for enumeration
# constructs. If you need more, try Enumeration.
# 
#   irb> Melons = Enumeration.of :watermelon, :honeydew, :cantelope
#   
#   irb> Melons::HONEYDEW
#   => :honeydew
#   
#   irb> Melons.enum
#   => [:watermelon, :honeydew, :cantelope]
#   
#   irb> Melons.to_s
#   => ["watermelon", "honeydew", "cantelope"]
#   
#   irb> Melons::Order
#   => {:cantelope=>2, :watermelon=>0, :honeydew=>1}
#   
# You can also use an array of strings to construct an Enumeration:
# 
#   irb> Colors = Enumeration.of %w{fuschia red bondi cerulean carnelian}
#   
#   irb> Colors::BONDI
#   => :bondi
#   
# 
# == Author: 
# 
# Karlin Fox
# 
# Atomic Object, http://atomicobject.com
# 
module Enumeration
  
  # Create an enumeration module.  You can provide a list of strings or symbols, as arguments or in an array.
  def self.of(*values)        
    if values[0].is_a? Array
      values = values[0]
    end
    order = (0...values.size).to_a
    values = values.map {|v| v.to_sym }
    klass = Module.new
    values.each do |value|
      const_name = value.to_s.upcase
      klass.const_set const_name, value.freeze
      klass.instance_eval do
        define_method value do
          value
        end
      end
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
  
  # Enumerate the values of an Enumeration as an array of symbols in definition order.
  def enum
    self.const_get(:Order).keys.sort_by {|x| self.const_get(:Order)[x]}
  end

  # Enumerate the values of an Enumeration as an array of strings in definition order.
  def to_s
    self.enum.map {|x| x.to_s}
  end
end
