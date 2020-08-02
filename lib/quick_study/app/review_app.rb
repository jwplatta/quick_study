require 'sinatra'
require 'pry'

class ReviewApp < Sinatra::Base
  set :views, File.expand_path('../views', __FILE__)

  get '/' do
    erb :index
  end

  get '/review' do
    binding.pry
    erb :index
  end
  # post '/restart' do
  # end
end

ReviewApp.run!
