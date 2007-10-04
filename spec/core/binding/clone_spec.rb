require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

@binding_clone = shared "Binding#clone" do |cmd|
  describe "Binding##{cmd}" do
    before(:each) do
      @b1 = BindingSpecs::Demo.new(99).get_binding
      @b2 = @b1.send(cmd)
    end

    it "return a copy of the Bind object" do
      @b1.should_not == @b2

      eval("@secret", @b1).should == eval("@secret", @b2)
      eval("square(2)", @b1).should == eval("square(2)", @b2)
      eval("self.square(2)", @b1).should == eval("self.square(2)", @b2)
      eval("a", @b1).should == eval("a", @b2)
    end

    it "should be a shallow copy of the Bind object" do
      eval("a = false", @b1)
      eval("a", @b2).should == false
    end
  end
end

describe "Binding#clone" do
  it_behaves_like(@binding_clone, :clone)
end
