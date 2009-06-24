require 'enumeration'

describe Enumeration do
  
  Numbers = Enumeration.of :first, :second, :third
  
  describe "basic features" do
    it "creates an enumeration module with the specified constants" do
      Numbers::FIRST.should == :first
      Numbers::SECOND.should == :second
      Numbers::THIRD.should == :third
    end

    it 'can be initialized with strings' do
      Enumeration.of('foo', 'fey')::FOO.should == :foo
    end
    
    it 'can be initialized with an array' do
      Enumeration.of(%w{foo fey})::FOO.should == :foo
    end

    it "establishes an ordering for the enumeration" do
      order_hash = Numbers::Order
      order_hash.size.should == 3
      order_hash[Numbers::FIRST].should == 0
      order_hash[Numbers::SECOND].should == 1
      order_hash[Numbers::THIRD].should == 2
    end

    it "cannot change order or enum" do
      lambda { Numbers::Order[Numbers::FIRST] = :foo }.should raise_error(/frozen/)
      lambda { Numbers::Order[:bar] = :foo }.should raise_error(/frozen/)
      lambda { Numbers::FIRST = :foo }.should raise_error(/frozen/)
    end
  end
  
  describe '#to_s' do
    it 'converts the enum to an array of strings' do
      Numbers.to_s.should == ['first', 'second', 'third']
    end
  end
  
  describe "#enum" do
    it 'should enumerate the constants in the Enumeration module in definition order' do
      Numbers.enum.include?(Numbers::FIRST).should be_true
      Numbers.enum.include?(Numbers::SECOND).should be_true
      Numbers.enum.include?(Numbers::THIRD).should be_true
      
      Numbers.enum.include?(:wrong).should be_false
    end
  end  
end
