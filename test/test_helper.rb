require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"

Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

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

def main_menu
  "1. Add a book\n2. Edit book info\n3. View book list\n4. Exit\n"
end

def actions_menu
  "Would you like to?\n1. Edit\n2. Delete\n3. Exit\n"
end
