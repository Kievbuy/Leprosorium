require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/'do
  erb "Hello World!"
end

get '/new' do
  erb :new
end

# === POST ===

post '/new' do
  content = params[:content]

  erb "You typed: #{content}"
end