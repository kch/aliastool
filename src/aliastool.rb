#!/usr/bin/env macruby
# encoding: utf-8
framework 'Foundation'
require   'hex_string'
require   'raisins'
require   'alias'

module Commands
  extend self
  USAGE = <<-EOS.gsub(/^ {4}/, '')
    Usage:
      {name} make TARGET [PATH]      # Creates an alias to TARGET in PATH. PATH defaults to the current directory.
      {name} resolve PATH            # Prints the target path from resolving the alias at PATH.
      {name} hex print PATH          # Prints alias data to PATH as a hex-encoded string.
      {name} hex resolve HEX_STRING  # Resolves HEX_STRING to a system path.
      {fill}                         # HEX_STRING is a hex-encoded string as dumped via 'hex print'.
      EOS

  def make
    path       = ARGV[2] || "."
    path       = File.join(path, File.basename(ARGV[1])) if File.directory? path
    path_url   = NSURL.fileURLWithPath(path)
    alias_data = Alias.data_from_path(ARGV[1], :for_file)
    raisingNSError { |e| NSURL.writeBookmarkData(alias_data, toURL: path_url, options: 0, error: e) }
  end

  def resolve
    puts Alias.path_from_alias_path(ARGV[1])
  end

  def hex_resolve
    puts Alias.path_from_data(HexString.decode(ARGV[2]).to_data)
  end

  def hex_print
    puts HexString.encode(Alias.data_from_path(ARGV[2]))
  end

  def usage
    h = { name: (s = File.basename($0)), fill: s.gsub(/./, ' ') }
    puts USAGE.gsub(/\{(\w+)\}/) { h[$1] }
    exit 1 unless %w( -h --help help usage ).include? ARGV[0]
  end
end

((cmd = ARGV[0, 1]) == %w( make        ) && ARGV[1] && !ARGV[3]) or
((cmd = ARGV[0, 1]) == %w( resolve     ) && ARGV[1] && !ARGV[2]) or
((cmd = ARGV[0, 2]) == %w( hex resolve ) && ARGV[2] && !ARGV[3]) or
((cmd = ARGV[0, 2]) == %w( hex print   ) && ARGV[2] && !ARGV[3]) or
((cmd = %w( usage )))

begin
  Commands.send(cmd.join("_"))
rescue => e
  $stderr.puts e.description
  exit 1
end
