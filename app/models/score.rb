#!/usr/bin/env ruby
# encoding: utf-8

class Score
  attr_accessor :name
  attr_accessor :pict_binary

  def to_md5
    p @pict_binary
    Digest::MD5.file(@pict_binary).to_s
  end

end
