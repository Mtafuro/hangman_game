require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './lib/hangman'

set :environment, :development
use Rack::Session::Pool, :expire_after => 2592000

configure do
  enable :sessions
  set :session_secret, "secret"
end

def new_game
  session[:game] = Hangyman.new
end

get "/" do
  new_game if session[:game].nil?
  @game = session[:game]

  erb :index, :locals => { :game_word => @game_word }
end
