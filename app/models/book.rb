class Book
  attr_reader :id, :errors
  attr_accessor :title, :topic, :ranking, :start_date, :end_date

  def initialize(title = nil)
    self.title = title
  end

  def ==(other)
    other.is_a?(Book) && other.id == self.id
  end

  def self.all
    Database.execute("select * FROM books").map do |row|
      book = Book.new
      book.title = row['title']
      book.topic = row['topic']
      book.ranking = row['ranking']
      book.start_date = row['start_date']
      book.end_date = row['end_date']
      book.instance_variable_set(:@id, row['id'])
      book
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

  def valid?
    if title.nil? or title.empty? or /^\d+$/.match(title)
      @errors = "\'#{title}\' is not a valid book title."
      false
    elsif Book.find_by_title(title)
      @errors = "\'#{title}\' already exists. Add a different book or choose 'edit' instead."
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    topic = "lobsters"
    ranking = "5"
    end_date = "2015/12/13"
    start_date = "2014/12/14"
    if @id.nil?
      Database.execute("INSERT INTO books (title, topic, ranking, end_date, start_date) VALUES (?,?,?,?,?)", title,topic, ranking, end_date, start_date)
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
    book.topic = row['topic']
    book.ranking = row['ranking']
    book.start_date = row['start_date']
    book.end_date = row['end_date']
    book.instance_variable_set(:@id, row['id'])
    book
  end
end
