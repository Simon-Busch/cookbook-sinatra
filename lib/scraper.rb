class Scraper
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def recipe_scrapper(ingredient)
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@ingredient}"
    Nokogiri::HTML(open(url))
  end

  def get_recipe_title(html_doc)
    html_doc.search('.recipe-card__title').map { |element| element.text.strip }
  end

  def get_rating(html_doc)
    html_doc.search('.recipe-card__rating__value').map { |element| element.text.strip }
  end

  def get_prep_time(html_doc)
    html_doc.search('.recipe-card__duration__value').map { |element| element.text.strip }
  end
end
