Doughboy
========

Doughboy is a Ruby library that strives to enable developers to easily make subprocessed shell calls. 

Usage
--------

Doughboy provides a compossible interface to crafting shell commands.

    command = Doughboy::Command.with_exec("ruby").with_options(["-v"])
    command.run!

Commands components can be set directly on any object.

    command = Doughboy::Command.new(:executable => "easy_install", :arguments => "some-python-library").run!

The preferred method is to use the composable chain methods.

Command Components
------------------

Each command is composed of 3 separate components: executable, options, arguments.

### Executable

When this component is set, the full-path is captured. If no path information could be determined, the executable passed will be used.

### Options

Options are command line switches that either start w/ "-" or "--". 

### Arguments

Arguments are items that are passed to the executable. They might be a list of ip addresses or files.

Origin of the Name
------------------

I wish I could say that it was meant to pay homage to the fighting men of the Lost Generation, but it's not. I was watching Boyz N The Hood. 

![Doughboy](http://2.bp.blogspot.com/_xdN0QQwsP1A/TDhzYsJhkpI/AAAAAAAAJZk/yjqX6ZNF1t8/s400/boyz_n_the_hood_xlg+ICE+Cube+crop.jpg)

Author
------

Joshua Schairbaum \o\ joshua.schairbaum@gmail.com /o/ @jschairb 

License
-------

See LICENSE file.