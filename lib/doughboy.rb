require 'open4'

require 'doughboy/command'
require 'doughboy/output'

module Doughboy

  def self.with_exec(command)
    Command.with_exec(command)
  end

end
