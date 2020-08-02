require 'sinatra'

class ReviewApp < Sinatra::Base
  set :bind, '0.0.0.0'
  set :port, 8888
  set :views, File.expand_path('../views', __FILE__)

  get '/review' do
    erb :index
  end
  # post '/restart' do
  # end
end

ReviewApp.run!
