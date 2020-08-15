require 'sinatra'
require 'quick_study'
require 'pry'

class ReviewApp < Sinatra::Base
  set :views, File.expand_path('../views', __FILE__)

  get '/' do
    question_files = Dir.glob(QuickStudy.configuration.quick_study_dir + '/json/*.json')

    questions = []

    question_files.each do |file|
      questions << File.open(file, 'r') do |json_file|
        JSON.parse(json_file.read)
      end
    end
    questions = questions.map { |set| set['questions'] }.flatten
    questions = questions.map { |q| QuickStudy::ReviewQuestion.new(q.transform_keys(&:to_sym)) }
    @questions = questions.shuffle

    erb :index
  end

  post '/' do
    question_count = params[:count].to_i

    question_files = Dir.glob(QuickStudy.configuration.quick_study_dir + '/json/*.json')

    questions = []

    question_files.each do |file|
      questions << File.open(file, 'r') do |json_file|
        JSON.parse(json_file.read)
      end
    end
    questions = questions.map { |set| set['questions'] }.flatten
    questions = questions.map { |q| QuickStudy::ReviewQuestion.new(q.transform_keys(&:to_sym)) }

    @questions = if question_count > 0
      questions.shuffle.slice(0, question_count)
    else
      questions.shuffle
    end

    erb :index
  end

  post '/parse' do
    system("quick_study -p")
    puts "Done Parsing\n"

    redirect '/'
  end
end

QuickStudy.configure do |c|
  c.quick_study_dir = File.expand_path('.')
end

ReviewApp.run!


