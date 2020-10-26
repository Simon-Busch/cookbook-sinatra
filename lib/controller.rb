require_relative 'view'
require_relative 'recipe'
require_relative 'scraper'
require 'nokogiri'
require 'open-uri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    name = @view.ask_user_for("recipe name")
    description = @view.ask_user_for("recipe description")
    rating = @view.ask_user_for("recipe rating")
    prep_time = @view.ask_user_for("recipe preparation time")
    recipe = Recipe.new(name, description, rating, prep_time)
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    display_recipes
    id = @view.done
    @cookbook.mark_as_done(id)
    display_recipes
  end

  def destroy
    display_recipes
    index = @view.ask_recipe_id
    @cookbook.remove_recipe(index)
    display_recipes
  end

  def import
    import_recipe_by_ingredient
  end

  private

  def import_recipe_by_ingredient
    # view ask the ingredient we are looking for
    scraper = Scraper.new(@view.define_ingredient)
    # create html_doc
    html_doc = scraper.recipe_scrapper(ingredient)
    # scrap recipe title
    recipes =  scraper.get_recipe_title(html_doc)[0...5]
    # display the recipes with index
    @view.display_recipe_from_html(recipes)
    # vue ask which recipe user wants to add with ID
    id = @view.select_recipe_to_import
    # get the rating
    rating = scraper.get_rating(html_doc)[0...5]
    # get the prep_time
    prep_time = scraper.get_prep_time(html_doc)[0...5]
    # generate new recipe
    recipe = Recipe.new(ingredient, recipes[id], rating[id], prep_time[id])
    # add new recipe
    @cookbook.add_recipe(recipe)
    # importing
    @view.importing(recipes[id])
    # display new list
    # display_recipes
  end

  def display_recipes
    @view.display(@cookbook.all)
  end

  # # scrapper
  # def recipe_scrapper(ingredient)
  #   url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{ingredient}"
  #   html_doc = Nokogiri::HTML(open(url))
  # end

  # def get_recipe_title(html_doc)
  #   html_doc.search('.recipe-card__title').map {|element| element.text.strip}
  # end

  # def get_rating(html_doc)
  #   html_doc.search('.recipe-card__rating__value').map {|element| element.text.strip}
  # end

  # def get_prep_time(html_doc)
  #   html_doc.search('.recipe-card__duration__value').map {|element| element.text.strip}
  # end
end
