require "highline/import"

class GenresController

  def index
    if Genre.count > 0
      genres = Genre.all
      choose do |menu|
        menu.prompt = ""
        genre.each do |book|
          menu.choice(genre.name){ action_menu(genre) }
        end
        menu.choice("Exit genre menu")
      end
    else
      say("No genres found. Please add a new genre.\n")
    end
  end

  def action_menu(genre)
    say("Would you like to?")
    choose do |menu|
      menu.prompt = ""
      menu.choice("Edit the book's genre") do
        edit(genre)
      end
      menu.choice("Go to main menu") do
        exit
      end
    end
  end

  def add(name)
    genre = Genre.new(name.strip)
    if genre.save
      "\"#{name}\" has been added.\n"
    else
      genre.errors
    end
  end

  def edit(genre)
    loop do
      user_input = ask("Enter a new genre name:")
      genre.name = user_input.strip
      if genre.save
        say("Genre has been updated to: \"#{genre.name}\"")
        return
      else
        say(genre.errors)
      end
    end
  end
end