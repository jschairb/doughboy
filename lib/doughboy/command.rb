module Doughboy
  class Command
    attr_accessor :arguments, :executable

    # Command.new
    # Command.new("python setup.py develop")
    # Command.new("python", "setup.py develop")
    # Command.new(:executable => "python", :arguments => "setup.py develop")

    def initialize(*args)
      return self if args.empty?
      parsed_args = args.first.is_a?(Hash) ? args.first : parse_string_args(args)

      self.executable = parsed_args[:executable]
      self.arguments  = parsed_args[:arguments]
    end

    def self.with_exec(*args)
      command = new(*args)
      command.run
    end

    def command
      [executable, arguments].join(" ")
    end

    def executable=(value)
      return nil if value.nil?

      full_path = `which #{value}`.strip
      @executable = full_path != "" ? full_path : value
    end

    def run
      Output.new( Open4::popen4(command) )
    end

    private
    def self.parse_executable(command)
      split_command = command.split(" ")
      parsed_command = { }

      parsed_command[:executable] = split_command[0]
      parsed_command[:arguments]  = split_command[1..(split_command.size-1)]
      parsed_command
    end

    def parse_string_args(args)
      if args.size == 1
        self.class.parse_executable(args.first)
      else
        { :executable => args.first, :arguments => args[1]}
      end
    end
  end
end
