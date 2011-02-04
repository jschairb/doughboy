require 'spec_helper'

module DoughBoy
  describe Command do
    describe ".new" do
      context "with a string argument" do
      end

      context "with a hash argument" do
        it "sets the arguments" do
          command = Command.new(:arguments => "setup.py develop")
          command.arguments.should_not be_nil
        end

        it "sets the executeable" do
          command = Command.new(:executable => "python")
          command.executable.should_not be_nil
        end

        it "sets the options" do
          options = "-r -i"
          command = Command.new(:options => options)
          command.options.should_not be_nil
        end

        # Command.with_exec("python setup.py develop).run
        # Command.with_exec("python").with_option("-r").with_arg("123456").run
        # Command.with_exec("mi").with_options([]).with_args([]).run
        # Command.with_exec("python") do |input|
        #   input.puts("exit()")
        # end
      end
    end

    describe ".with_exec" do
      it "returns a Command" do
        Command.with_exec("ruby").should be_kind_of(Command)
      end

      context "with a string of executable and argument" do
        it "assigns the executable" do
          command = Command.with_exec("ifconfig")
          command.executable.should == `which ifconfig`.strip
        end

        it "assigns the arguments" do
          command = Command.with_exec("ps aux")
          command.arguments.should == "aux"
        end

        it "assigns the options" do
          command = Command.with_exec("mi -r")
          command.options.should == ["-r"]
        end
      end

      context "with an executable" do
        it "assigns the executable" do
          Command.with_exec("ruby").executable.should include("ruby")
        end
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
      it "joins the executable, options, and arguments" do
        full_command = "/bin/ps  aux"
        command = Command.new(:executable => "ps", :options => "", :arguments => "aux")
        command.command.should == full_command
      end
    end

    describe "#executable=" do
      it "sets the full path of the executable" do
        ruby = `which ruby`.strip

        command = Command.new(:executable => "ruby")
        command.executable.should == ruby
      end
    end

    describe "#options=" do
      context "with an array of options" do
        it "sets the options as an array" do
          options = ["-r", "-i"]
          command = Command.new(:options => options)
          command.options.should == options
        end
      end

      context "with a string of options" do
        options = "-r -i"
        command = Command.new(:options => options)
        command.options.should == ["-r", "-i"]
      end
    end

    describe "#run!" do
      it "runs the command" do
        full_command = "/bin/ps  aux"
        command = Command.new()
        command.stub!(:command).and_return(full_command)

        Open4.should_receive(:popen4).with(full_command).
          and_return([1234, StringIO.new, StringIO.new, StringIO.new])
        command.run!
      end

      it "returns an output object" do
        command = Command.new(:executable => "ps", :options => "", :arguments => "aux")
        command.run!.should be_kind_of(Output)
      end
    end
  end
end
