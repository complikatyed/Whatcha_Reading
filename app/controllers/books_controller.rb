require "highline/import"

class BooksController

  def index
    if Book.count > 0
      books = Book.all
      books_string = ""
      books.each_with_index do |book, index|
        books_string << "Title:\s #{book.title}\nTopic:\s #{book.topic}\nRank:\s\s #{book.rank} stars\n"
        books_string << "Start:\s #{book.start}\nFinish: #{book.finish}\n\n"
      end
      say(books_string)
    else
      say("No books found. Please add a new book.\n")
    end
  end

  def add_book
    title = ask("What book would you like to add?")
    while title.strip.empty?
      puts "Title can't be blank."
      title = ask("What book would you like to add?")
    end
    start = ask("Please enter a reading start date: yyyy/mm/dd.")
    while start.strip.empty?
      puts "Please try again."
      start = ask("Please enter a reading start date: yyyy/mm/dd.")
    end
    response = self.add(title, start)
    say(response) unless response.nil?
  end

  def add(title, start)
    book = Book.new
    book.title = title
    book.start = start
    if book.save
      "#{title.upcase} has been added with a reading start date of #{start}.\n\n"
    else
      "#{book.errors.full_messages.join}"
    end
  end

  def edit_book
    books_controller = BooksController.new
    title = ask("Which book's record would you like to update?")
    book = Book.find_by_title(title)
    new_record = ""
    original_record = "\n"
    original_record << "Title:\s #{book.title}\nTopic:\s #{book.topic}\nRank:\s\s #{book.rank} stars\n"
    original_record << "Start:\s #{book.start}\nFinish: #{book.finish}\n \n"
    say(original_record)
    loop do
      choice = ask("Choose something to update, or type exit.")
      if choice == "title"
        book.title = ask("Please enter the new title.")
        while book.title.empty?
          puts "Title can't be blank."
          book.title = ask("Please enter the new title.")
        end
      elsif choice == "topic"
        book.topic = ask("Please enter a topic sentence. There is a 200 character limit.")
        while book.topic.empty? or book.topic.length > 200
          puts "Please try again. That sentence won't work."
          book.topic = ask("Please enter a topic sentence. There is a 200 character limit.")
        end
      elsif choice == "rank"
        book.rank = ask("Please enter a rank from 1 (\"meh\") to 5 (\"It was better than Cats!\")")
      elsif choice == "start"
        book.start = ask("Please enter a reading start date: yyyy/mm/dd.")
        while book.start.empty?
          puts "Please try again."
          book.start = ask("Please enter a reading start date: yyyy/mm/dd.")
        end
      elsif choice == "finish"
        book.finish = ask("Please enter a reading end date: yyyy/mm/dd.")
        while book.finish.empty?
          puts "Please try again."
          book.finish = ask("Please enter a reading end date: yyyy/mm/dd.")
        end
      elsif choice == "exit"
        break
      end
    end

    if book.save
      new_record << "Title:\s #{book.title}\nTopic:\s #{book.topic}\nRank:\s\s #{book.rank} stars\n"
      new_record << "Start:\s #{book.start}\nFinish: #{book.finish}\n \n"
      say("\nThe record has been updated to:\n#{new_record}.")
      return
    else
      say(book.errors)
    end
  end

  def exit_program
    say("Go read something!\n")
    exit
  end

end
