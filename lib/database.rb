require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS books (
      id integer PRIMARY KEY AUTOINCREMENT,
      title varchar(200) NOT NULL,
      start_date date,
      end_date date,
      topic varchar(200),
      ranking integer,
      genre_id integer NOT NULL
    );
    SQL
    # Database.execute <<-SQL
    # CREATE TABLE IF NOT EXISTS authors (
    #   id integer PRIMARY KEY AUTOINCREMENT,
    #   last_name varchar (30) NOT NULL,
    #   first_name varchar (30) NOT NULL
    # );
    # SQL
    # Database.execute <<-SQL
    # CREATE TABLE IF NOT EXISTS genres (
    #   id integer PRIMARY KEY AUTOINCREMENT,
    #   name varchar (30) NOT NULL
    # );
    # SQL
    # Databse.execute <<-SQL
    # CREATE TABLE IF NOT EXISTS book_authors (
    #   id integer PRIMARY KEY AUTOINCREMENT,
    #   book_id integer,
    #   author_id integer
    #   );
    # SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/whatcha_reading_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
    @@db.results_as_hash = true
  end
end
