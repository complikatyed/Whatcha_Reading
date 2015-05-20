require "highline/import"

class BooksController

  def index
    if Book.count > 0
      books = Book.all
      choose do |menu|
        menu.prompt = ""
        books.each do |book|
          menu.choice(book.title){ action_menu(book) }
        end
        menu.choice("Go to the main menu")
      end
    else
      say("No books found. Please add a new book.\n")
    end
  end

  def action_menu(book)
    say("Would you like to?")
    choose do |menu|
      menu.prompt = ""
      menu.choice("Edit the book's title") do
        edit(book)
      end
      menu.choice("Edit the book's genre") do
        edit(genre)
      end
      menu.choice("Go to main menu") do
        exit
      end
    end
  end

  def add(title)
    book = Book.new(title.strip)
    if book.save
      "\"#{title}\" has been added.\n"
    else
      book.errors
    end
  end

  def edit(book)
    loop do
      user_input = ask("Enter a new title:")
      book.title = user_input.strip
      if book.save
        say("Book has been updated to: \"#{book.title}\"")
        return
      else
        say(book.errors)
      end
    end
  end
end