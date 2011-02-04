require 'spec_helper'

module DoughBoy
  describe Output do
    describe ".new" do
      before(:each) do
        #popen [pid, stdin, stdout, stderr]
        @response = Open4::popen4("ps aux")
        @output = Output.new(@response)
      end

      it "sets the pid" do
        @output.pid.should == @response[0]
      end

      it "sets the stdin" do
        @output.stdin.should == @response[1]
      end

      it "sets the stdout" do
        @output.stdout.should == @response[2]
      end

      it "sets the stderr" do
        @output.stderr.should == @response[3]
      end
    end

    describe "#text" do
      it "returns the stdout" do
        response = Open4::popen4("ruby -v")
        output = Output.new(response)

        expected = `ruby -v`.strip
        output.text.should == expected
      end
    end
  end
end
