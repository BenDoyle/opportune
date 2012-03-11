require 'spec_helper'

describe Opportune::OpportunitySimulation do
  describe "an ititialized OpportunitySimulation" do
    before do
      @actions  = [Action.new(-23){'foo'}]
      @outcomes = [Outcome.new(23)]
      @os = OpportunitySimulation.new(@actions, @outcomes)
    end
    it "should list available actions" do
      @os.list_actions.should == @actions
    end
    it "should list available outcomes" do
      @os.list_outcomes.should == @outcomes
    end
  end
end
