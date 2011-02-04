module Doughboy
  class Command
    attr_accessor :arguments, :executable

    def initialize(*args)
      if args.any?
        local_args = args.first

        %w( arguments executable ).each do |arg|
          self.send("#{arg}=", local_args[arg.intern])
        end
      end
    end

    def self.with_exec(command)
      parsed_command = parse_command(command)

      new( :executable     => parsed_command[:executable],
           :arguments      => parsed_command[:arguments])
    end

    def command
      [executable, arguments].join(" ")
    end

    def executable=(value)
      return nil if value.nil?
      full_path = `which #{value}`.strip
      @executable = full_path != "" ? full_path : value
    end

    def run!
      Output.new( Open4::popen4(command) )
    end

    private
    def self.parse_command(command)
      split_command = command.split(" ")
      parsed_command = { }

      parsed_command[:executable] = split_command[0]
      parsed_command[:arguments]  = split_command[1..(split_command.size-1)]
      parsed_command
    end

  end
end
