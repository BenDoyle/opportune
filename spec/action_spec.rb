require 'spec_helper'

describe Opportune::Action do
  describe "An initialized Action" do
    before do
      @payload = lambda{'foo'}
      @utility = -23
      @a = Action.new(@utility,@payload)
    end
    it "should return a utility" do
      @a.utility.should == -23
    end
    it "should contain a payload" do
      @a.perform.should == @payload.call
    end
  end
end
