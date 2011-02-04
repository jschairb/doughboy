require 'spec_helper'

describe Doughboy do

  describe "with_exec" do
    it "returns a command" do
      Doughboy.with_exec("ruby -v").should be_kind_of(Doughboy::Command)
    end
  end
end
