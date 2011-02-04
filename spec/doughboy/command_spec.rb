require 'spec_helper'

module Doughboy
  describe Command do
    describe ".new" do
      context "with no arugments" do
        it "does not error" do
          lambda { Command.new }.should_not raise_exception
        end
      end

      context "with a single string argument" do
        it "sets the executable" do
          command = Command.new("python setup.py develop")
          command.executable.should_not be_nil
        end

        it "sets the arguments" do
          command = Command.new("python setup.py develop")
          command.arguments.should_not be_nil
        end
      end

      context "with a double string argument" do
        it "sets the executable" do
          command = Command.new("python", "setup.py develop")
          command.executable.should_not be_nil
        end

        it "sets the arguments" do
          command = Command.new("python", "setup.py develop")
          command.arguments.should_not be_nil
        end

      end

      context "with a hash argument" do
        it "sets the executeable" do
          command = Command.new(:executable => "python")
          command.executable.should_not be_nil
        end

        it "sets the arguments" do
          command = Command.new(:arguments => "setup.py develop")
          command.arguments.should_not be_nil
        end

        # Command.with_exec("python setup.py develop).run
        # Command.with_exec("python").with_arg("123456").run
        # Command.with_exec("mi").with_args([]).run
        # Command.with_exec("python") do |input|
        #   input.puts("exit()")
        # end
      end
    end

    describe ".with_exec" do

      it "returns a Output" do
        Command.with_exec("ruby").should be_kind_of(Output)
      end

    end

    describe "#arguments=" do
      it 'sets the arguments' do
        arguments = "setup.py develop"

        command = Command.new(:arguments => arguments)
        command.arguments.should == arguments
      end
    end

    describe "#command" do
      it "joins the executable and arguments" do
        full_command = "/bin/ps aux"
        command = Command.new(:executable => "ps", :options => "", :arguments => "aux")
        command.command.should == full_command
      end

      it "returns them in the proper order" do
        python = `which python`.strip
        command = Command.new("python mbu_information.py -r 218298")
        command.command.should == "#{python} mbu_information.py -r 218298"
      end
    end

    describe "#executable=" do
      it "sets the full path of the executable" do
        ruby = `which ruby`.strip

        command = Command.new(:executable => "ruby")
        command.executable.should == ruby
      end

      it "sets the value sent if no path could be determined" do
        command = Command.new(:executable => "noexist")
        command.executable.should == "noexist"
      end
    end

    describe "#run" do
      it "runs the command" do
        full_command = "/bin/ps  aux"
        command = Command.new()
        command.stub!(:command).and_return(full_command)

        Open4.should_receive(:popen4).with(full_command).
          and_return([1234, StringIO.new, StringIO.new, StringIO.new])
        command.run
      end

      it "returns an output object" do
        command = Command.new(:executable => "ps", :arguments => "aux")
        command.run.should be_kind_of(Output)
      end
    end

    describe "#run!" do
      it "runs the command" do
        full_command = "/bin/ps  aux"
        command = Command.new()
        command.stub!(:command).and_return(full_command)

        Open4.should_receive(:popen4).with(full_command).
          and_return([1234, StringIO.new, StringIO.new, StringIO.new])
        command.run
      end

      it "returns an output object" do
        command = Command.new(:executable => "ps", :arguments => "aux")
        command.run.should be_kind_of(Output)
      end
    end
  end
end
