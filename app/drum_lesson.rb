#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra/base'
require 'active_record'
require 'haml'

require_relative 'models/pictures'
require_relative 'models/score'
require_relative 'models/score_pict_gen'
require_relative 'db'

class Drum_lesson < Sinatra::Base
  configure do
    DB.connect(
      File.expand_path(File.join(root, '..')),
      ENV['RACK_ENV']
    )
  end
  set :public_folder, File.expand_path(File.join(root, '..', 'public'))


  get '/' do
    @pictures = Pictures.order('id DESC')
    haml :index
  end

  get '/new' do
    haml :new
  end

  get '/picture/:picthash' do
    @picthash = params[:picthash]
    haml :picture
  end

  post '/create' do
    if params[:file]
      score = Score.new
#      puts params[:file][:tempfile].to_s
      score.pict_binary = Score_pict_gen.pict_resize(params[:file][:tempfile].read)
      score.name = :pattern_name
      save_path = "./public/pictures/#{score.to_md5}"
      File.open(save_path, 'wb') do |f|
        f.write tmpfile.read
      end
      Pictures.create!(realname: params[score.name], md5hash: picture.to_md5, owner_id: 'tomcha' )
    end
    redirect '/'
  end
end
