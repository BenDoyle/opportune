require 'spec_helper'

describe Opportune::Outcome do
  describe "An initialized Outcome" do
    before do
      @utility = -23
      @a = Action.new(@utility)
    end
    it "should return a utility" do
      @a.utility.should == -23
    end
  end
end
