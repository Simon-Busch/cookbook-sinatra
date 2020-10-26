require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, '0.0.0.0'

###

require_relative 'lib/cookbook'
require_relative 'lib/recipe'
# require_relative 'lib/controller'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end




# ne pas utiliser controller ni router

get '/' do
  erb :home
end

# get equivalent router
get '/index' do  # url 
  # controleur
  csv_file   = File.join(__dir__, 'lib/recipes.csv')
  cookbook   = Cookbook.new(csv_file)
  # @ = pour la var qu'on veut passer dans la vue
  # @ = variable globale dans le GET
  @recipe = cookbook.all
  erb :index
end


get '/new' do
  erb :new
end

post '/recipes' do
  csv_file   = File.join(__dir__, 'lib/recipes.csv')
  cookbook   = Cookbook.new(csv_file)
  recipe = Recipe.new(params[:recipe_name], params[:recipe_description], params[:recipe_rating], params[:recipe_prep_time])
  cookbook.add_recipe(recipe)
  redirect to '/index'
end

