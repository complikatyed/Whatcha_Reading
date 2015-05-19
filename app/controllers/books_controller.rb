require "highline/import"

class BooksController

	def index
		if Book.count > 0
			books = Book.all
			books_string = ""
			books.each_with_index do |book, index|
				books_string << "#{index + 1}. #{book.title}\n"
			end
			books_string
		else
			"No books found. Please add a new book.\n"
		end
	end

	def add(title)
		title_cleaned = title.strip
		book = Book.new(title_cleaned)
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
				say("Book has been updated to: \"#{book.name}\"")
				return
			else
				say(book.errors)
			end
		end
	end
end