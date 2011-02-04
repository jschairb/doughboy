require 'open4'

require 'doughboy/command'
require 'doughboy/output'

module Doughboy

  def self.with_exec(*args)
    Command.with_exec(*args)
  end

  def self.new(*args)
    Command.new(*args)
  end

end
