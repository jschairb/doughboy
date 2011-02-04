module Doughboy
  class Command
    attr_accessor :arguments, :executable, :options

    def initialize(*args)
      if args.any?
        local_args = args.first
        self.arguments  = local_args[:arguments]
        self.executable = local_args[:executable]
        self.options    = local_args[:options]
      end
    end

    def self.with_exec(command)
      parsed_command = parse_command(command)
      executable = parsed_command[:executable]
      arguments  = parsed_command[:arguments]
      options    = parsed_command[:options]

      new(:executable => executable, :arguments => arguments, :options => options)
    end

    def command
      [executable, options, arguments].join(" ")
    end

    def executable=(value)
      return nil if value.nil?
      full_path = `which #{value}`.strip
      @executable = full_path != "" ? full_path : value
    end

    def options=(value)
      return nil if value.nil?
      @options = value.is_a?(Array) ? value : value.split(" ")
    end

    def run!
      Output.new( Open4::popen4(command) )
    end

    private
    def self.parse_command(command)
      split_command = command.split(" ")
      parsed_command = { }
      args_and_opts = split_command[1..(split_command.size-1)]

      parsed_command[:executable] = split_command[0]
      parsed_command[:arguments] = args_and_opts.select { |t| !t.include?("-") }.join(" ")
      parsed_command[:options]   = args_and_opts.select { |t| t.include?("-") }
      parsed_command
    end

  end
end
