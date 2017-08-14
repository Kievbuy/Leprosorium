require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/'do
  erb "Hello World!"
end