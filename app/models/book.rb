class Book
  attr_reader :id, :errors
  attr_accessor :title

  def initialize(title = nil)
    self.title = title
  end

  def ==(other)
    other.is_a?(Book) && other.id == self.id
  end

  def self.all
    Database.execute("select * from books").map do |row|
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from books")[0][0]
  end

  def self.find(id)
    row = Database.execute("select * from books where id = ?", id).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.find_by_title(title)
    row = Database.execute("select * from books where title LIKE ?", title).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.check_for_duplicates(title)
    row = Database.execute("select * from books where title LIKE ?", title).first
    if row.nil?
      false
    else
      puts "\'#{title}\' already exists. Try edit instead."
      true
    end
  end

  def valid?
    if title.nil? or title.empty? or /^\d+$/.match(title)
      @errors = "\'#{title}\' is not a valid book title."
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    if @id.nil?
      Database.execute("INSERT INTO books (title) VALUES (?)", title)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    else
      Database.execute("UPDATE books SET title=? WHERE id=?", title, id)
      true
    end
  end

  private

  def self.populate_from_database(row)
    book = Book.new
    book.title = row['title']
    book.instance_variable_set(:@id, row['id'])
    book
  end
end
