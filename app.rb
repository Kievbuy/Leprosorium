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
  @db.execute 'CREATE TABLE if not exists Posts (
  `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
  `created_date`	TEXT,
  `content`	TEXT
  );'
  @db.execute 'CREATE TABLE if not exists Comments (
  `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
  `created_date`	TEXT,
  `content`	TEXT,
  `post_id` INTEGER
  );'
end

get '/'do

  @results = @db.execute 'select * from Posts order by id desc'

  erb :index
end

get '/new' do
  erb :new
end

get '/details/:post_id' do
  post_id = params[:post_id]

  @results = @db.execute 'select * from Posts where id = ?', [post_id]

  @row = @results[0]

  erb :details
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

post '/details/:post_id' do
  post_id = params[:post_id]

  results = @db.execute 'select * from Posts where id = ?', [post_id]

  erb :details
end