#!/usr/bin/env macruby
# encoding: utf-8

# give it a lick; mmm it tastes like raisins
def raisingNSError
  e = Pointer.new_with_type(:object)
  yield(e).tap { e[0].nil? or raise e[0].description }
end
