require 'sinatra'
require 'sinatra/reloader'

require './lib/hangman'


get "/" do
  erb :home
end
