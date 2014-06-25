#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra/base'
require 'active_record'
require 'haml'

require_relative 'models/pictures'
require_relative 'models/score'
require_relative 'models/post_score'
require_relative 'db'

class Drum_lesson < Sinatra::Base
  configure do
    DB.connect(
      File.expand_path(File.join(root, '..')),
      ENV['RACK_ENV']
    )
  end
  set :public_folder, File.expand_path(File.join( root, '..', 'public'))


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
      save_path = File.expand_path( File.join( 'public', 'pictures'))
      file_name = params[:file][:filename]
      File.open("#{save_path}/#{file_name}", 'wb') do |f|
        f.write params[:file][:tempfile].read
      end
      Post_score.pict_resize("#{save_path}/#{file_name}")
      File.rename( "#{save_path}/#{file_name}", "#{save_path}/#{Post_score.to_md5("#{save_path}/#{file_name}")}")
    else 
      redirect '/new'
    end
    redirect '/'
  end
end
