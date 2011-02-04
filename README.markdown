Doughboy
========

Doughboy is a Ruby library that strives to enable developers to simply make subprocessed shell calls. 

Usage
--------

Doughboy provides a composable interface to crafting shell commands. The following composition methods are available:

    Doughboy.new("ruby -v")
    Doughboy.new("python", "setup.py")
    Doughboy.new(:executable => "python", :arguments => "setup.py")

Doing any of these things will return a command object that can be told to run:

    command = Doughboy.new("ruby -v")
    command.run #=> returns and Output object

The Output object includes the output methods: pid, stdin, stdout, stderr. For a shortcut, use the .text method. To create and run a new command, use the .with_exec shortcut:

    output = Doughboy.with_exec("ruby -v") #=> returns an Output object

Command Components
------------------

Each command is composed of 2 components, executable and arguments.

### Executable

When this component is set, the full-path is captured. If no path information could be determined, the executable passed will be used.

### Arguments

Arguments are items that are passed to the executable. They might be a list of switches, ip addresses or files.

Origin of the Name
------------------

I wish I could say that it was meant to pay homage to the fighting men of the Lost Generation, but it's not. I was watching Boyz N The Hood. We got a problem here?

![Doughboy](http://2.bp.blogspot.com/_xdN0QQwsP1A/TDhzYsJhkpI/AAAAAAAAJZk/yjqX6ZNF1t8/s400/boyz_n_the_hood_xlg+ICE+Cube+crop.jpg)

Author
------

Joshua Schairbaum \o\ joshua.schairbaum@gmail.com /o/ @jschairb 

License
-------

See LICENSE file.