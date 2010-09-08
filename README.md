# Alias Tool

Command line tool to deal with Mac alias files.


## Usage

    aliastool make TARGET [PATH]      # Creates an alias to TARGET in PATH. PATH defaults to the current directory.
    aliastool resolve PATH            # Prints the target path from resolving the alias at PATH.
    aliastool hex print PATH          # Prints alias data to PATH as a hex-encoded string.
    aliastool hex resolve HEX_STRING  # Resolves HEX_STRING to a system path.
                                      # HEX_STRING is a hex-encoded string as dumped via 'hex print'.


## Running

You can run `src/aliastool.rb` directly, or you can compile it by running `rake`.

Rake will generate a binary `aliastool` which you can then put wherever you want.


## Compiling

    $ rake


## Requirements

It requires MacRuby 0.7, which is not out yet.

You can either [download a nightly][nightlies] or [build your own][source].

[nightlies]: http://www.macruby.org/files/nightlies/
[source]:    http://www.macruby.org/source.html
