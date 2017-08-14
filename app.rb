require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/'do
  erb "Hello World!"
end

get '/new' do
  erb "Hello World"
end