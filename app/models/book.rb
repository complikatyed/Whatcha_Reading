class Book
  attr_reader :id, :errors
  attr_accessor :title

  def initialize(title = nil)
    self.title = title
  end

  def self.all?
    Database.execute("select * from books by index").map do |row|
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from books")[0][0]
  end

  def self.find
    row = Database.execute("select * from scenarios where id = ?", id).first
    if row.nil?
      nil
    else
      populate_from_database
    end
  end

  def valid?
    if title.nil? or title.empty? or /^\d+$/.match(title)
      @errors = "\"#{title}\" is not a valid book title."
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    Database.execute("INSERT INTO books (title) VALUES (?)", title)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  private

  def self.populate_from_database(row)
    book = Book.new
    book.title = row['title']
    book.instance_variable_set(:@id, row['id'])
    book
  end
end
