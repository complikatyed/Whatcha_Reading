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
        books_string << "Title:\s #{book.title}\nTopic:\s #{book.topic}\nRank:\s\s #{book.ranking} stars\n"
        books_string << "Start:\s #{book.start_date}\nFinish: #{book.end_date}\n \n"
      end
      say(books_string)
      exit
    else
      say("No books found. Please add a new book.\n")
    end
  end

  def edit_book
    books_controller = BooksController.new
    title = ask("Which book's record would you like to update?")
    book = Book.find_by_title(title)
    new_record = ""
    original_record = "\n"
    original_record << "Title:\s #{book.title}\nTopic:\s #{book.topic}\nRank:\s\s #{book.ranking} stars\n"
    original_record << "Start:\s #{book.start_date}\nFinish: #{book.end_date}\n \n"
    say(original_record)
    loop do
      choice = ask("Choose something to update, or type exit.")
      if choice == "title"
        book.title = ask("Please enter the new title.")
        while book.title.empty?
          puts "'#{book.title} won't work as a title."
          book.title = ask("Please enter the new title.")
        end
      elsif choice == "topic"
        book.topic = ask("Please enter a topic sentence. There is a 200 character limit.")
        while book.topic.empty? or book.topic.length > 200
          puts "Please try again. That sentence won't work."
          book.topic = ask("Please enter a topic sentence. There is a 200 character limit.")
        end
      elsif choice == "rank"
        book.ranking = ask("Please enter a ranking from 1 (\"meh\") to 5 (\"It was better than Cats!\")")
        while book.ranking.empty? or book.ranking.length > 1
          puts "Please try again."
          book.ranking = ask("Please enter a ranking from 1 to 5.")
        end
      elsif choice == "start"
        book.start_date = ask("Please enter a reading start date: yyyy/mm/dd")
        while book.start_date.empty?
          puts "Please try again."
          book.start_date = ask("Please enter a reading start date: yyyy/mm/dd")
        end
      elsif choice == "finish"
        book.end_date = ask("Please enter a reading end date: yyyy/mm/dd")
        while book.end_date.empty?
          puts "Please try again."
          book.end_date = ask("Please enter a reading end date: yyyy/mm/dd")
        end
      elsif choice == "exit"
        break
      end
    end

    if book.update
      new_record << "Title:\s #{book.title}\nTopic:\s #{book.topic}\nRank:\s\s #{book.ranking} stars\n"
      new_record << "Start:\s #{book.start_date}\nFinish: #{book.end_date}\n \n"
      say("\nThe record has been updated to:\n#{new_record}.")
      return
    else
      say(book.errors)
    end
  end
end
