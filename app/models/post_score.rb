#!/usr/bin/env ruby
# encoding: utf-8
require 'digest/md5'
require 'rmagick'

class Post_score

  def self.to_md5( file_path)
    md5_hash = Digest::MD5.new.file( file_path)
    md5_hash.to_s
  end

  def self.pict_resize( file_path)
    width = 230
    height = 100
    image = Magick::Image.read( file_path).first
    image.resize_to_fit!( width, 10000).crop!( Magick::CenterGravity, width, height)
    image.write( file_path)
  end

end
