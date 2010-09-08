#!/usr/bin/env macruby
# encoding: utf-8

module HexString
  extend self

  def encode(s)
    s.to_str.unpack("H*").join
  end

  def decode(s)
    # [s].pack("H*")
    # This is a faster implementation of the above when dealing with gigantic strings.
    # It that calls pack in smaller chunks. I got to 0x40000 empirically, but YMMV
    s.to_str.scan(/.{1,#{0x40000}}/).inject("".force_encoding("BINARY")) { |acc, part| acc << [part].pack("H*") }
  end
end
