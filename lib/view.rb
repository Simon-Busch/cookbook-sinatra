class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      status = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1} - #{status} -  #{recipe.name.capitalize} ----"
      puts " #{recipe.description.capitalize} || rating is #{recipe.rating}/5 || prep time is #{recipe.prep_time}"
    end
  end

  def ask_user_for(something)
    puts "What is the #{something} ?"
    print "> "
    gets.chomp
  end

  def ask_recipe_id
    puts "Which recipe do you want to delete ?"
    print "> "
    gets.chomp.to_i - 1
  end

  def define_ingredient
    puts "What are you looking for ?"
    print "> "
    gets.chomp
  end

  def display_recipe_from_html(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe}"
    end
  end

  def select_recipe_to_import
    puts "Which recipe do you want to import ?"
    print "> "
    gets.chomp.to_i - 1
  end

  def importing(recipe)
    puts "Importing #{recipe} to you data base ..."
  end

  def done
    puts "Which recipe do you want to mark as done"
    print "> "
    gets.chomp.to_i - 1
  end
end
