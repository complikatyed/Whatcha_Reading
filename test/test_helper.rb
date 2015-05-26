ENV["TEST"] = "true"
require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"
require_relative "../lib/environment"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM books;")
  end
end

def create_book(title)
  Database.execute("INSERT INTO books (title) VALUES (?)", title)
end

def exit_from(pipe)
  pipe.puts "Exit"
  pipe.puts "4"
  main_menu + "Go read something!\n"
end

def main_menu
  "1. Add a book\n2. Edit book info\n3. View the book list\n4. Exit the program\n"
end

# def actions_menu
#   "Would you like to?\n1. Edit the book's title\n2. Edit the book's genre\n3. Go to main menu\n"
# end

# def genres_menu
#   "Please choose a genre:\n1. Sci-Fi/Fantasy\n2. 18th-19th century realism\n3. Modern realism\n4. Mystery/Thriller\n5. Poetry\n6. Biography/Memoir\n7. Other non-fiction\n"
# end