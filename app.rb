require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
  @db = SQLite3::Database.new 'leprosorium.db'
  @db.results_as_hash = true
end

before do
  init_db
end

configure do
  init_db
  @db.execute 'CREATE TABLE if not exists `Posts` (
  `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
  `created_date`	TEXT,
  `content`	TEXT
  );'
end

get '/'do
  erb :index
end

get '/new' do
  erb :new
end

# === POST ===

post '/new' do
  @content = params[:content]

  if @content.length <= 0
    @error = "Please, type the text"
    return erb :new
  end

  @db.execute 'insert into Posts (content, created_date) values (?, datetime())', [@content]

  erb "You typed: #{@content}"
end