#!/usr/bin/env ruby
# encoding: utf-8

require 'rmagick'

class Score_pict_gen 
  def self.pict_resize(original_image)
    p original_image.class
    width = 230
    height = 100
    image = Magick::Image.from_blob(original_image).first
    return image.resize_to_fit(width, 1000).crop(Magick::CenterGravity, width, height)
  end
end
