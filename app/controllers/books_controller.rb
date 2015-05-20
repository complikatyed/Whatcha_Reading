require "highline/import"

class BooksController

  def add(title)
    book = Book.new(title.strip)
    if book.save
      "\"#{title}\" has been added.\n"
    else
      book.errors
    end
  end

  def index
    if Book.count > 0
      books = Book.all
      books_string = ""
      books.each_with_index do |book, index|
        books_string << "#{index + 1}. #{book.title}\n"
        books_string << "\s\s Topic: #{book.topic}\n \s\sRanking: #{book.ranking}\n"
        books_string << "\s\s Start Date: #{book.start_date}\n\s\s End Date:\s\s #{book.end_date}\n \n"
      end

      say(books_string)
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

  def edit(title)
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