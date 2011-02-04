require 'spec_helper'

describe Doughboy do

  describe ".new" do
    it "returns a Command" do
      Doughboy.new("ruby -v").should be_kind_of(Doughboy::Command)
    end
  end

  describe ".with_exec" do
    it "returns returns the output from a command" do
      Doughboy.with_exec("ruby -v").should be_kind_of(Doughboy::Output)
    end
  end
end
