require 'rubygems' 
require 'bundler/setup'

require 'sinatra'
require 'erb'
require 'ostruct'
require 'yaml'

require './snippet'
require './database'

file = 'data.yaml'

get '/' do
  @snippets = Database.read file
  erb :all
end

get '/snippet/:id' do
  @snippet = Database.fetch file, params[:id].to_i
  erb :snippet
end

get '/edit/:id' do
  @snippet = Database.fetch file, params[:id].to_i
  erb :edit
end

post '/edit/:id' do
  Snippet.create params
  redirect to('/snippet/' + params[:id].to_s)
end

get '/delete/:id' do
  Snippet.delete params[:id].to_i
  redirect to('/')
end

get '/new' do
  erb :new
end

post '/new' do
  Snippet.create params[:short], params[:long_info]
  redirect to('/')
end