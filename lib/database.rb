require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS books (
      id integer PRIMARY KEY AUTOINCREMENT,
      title varchar(200) NOT NULL,
      topic varchar(200),
      rank integer,
      start date,
      finish date
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = Environment.current
    database = "db/whatcha_reading_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
    @@db.results_as_hash = true
  end
end
