module DoughBoy
  class Output
    attr_accessor :pid, :stdin, :stdout, :stderr

    def initialize(*args)
      local_args  = args.first
      self.pid    = local_args[0]
      self.stdin  = local_args[1]
      self.stdout = local_args[2]
      self.stderr = local_args[3]
    end

    def text
      stdout.read.strip
    end

  end
end
