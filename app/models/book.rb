class Book < ActiveRecord::Base
  validates :title, uniqueness: { message: "has already been taken. Please add a different book."},
    presence: { message: "can't be blank."},
    format: { with: /[a-zA-Z]/, allow_blank: true, message: "must contain at least 1 letter."}

end

  # def initialize(title, start_date)
  #   super(title: title)
  #   super(start_date: start_date)
  # end

  # validates :topic,
  #   presence: {},
  #   allow_blank: false,
  # validates :ranking,
  #   presence: {},
  #   allow_blank: false,
  # validates :start_date,
  #   presence: {},
  #   allow_blank: false,
  # validates :end_date,
  #   presence: {},
  #   allow_blank: false,

  # has_many :genres

#   def initialize(title = nil)
#     self.title = title
#   end

#   def ==(other)
#     other.is_a?(Book) && other.id == self.id
#   end

#   def self.all
#     Database.execute("select * FROM books").map do |row|
#       book = Book.new
#       book.title = row['title']
#       book.topic = row['topic']
#       book.ranking = row['ranking']
#       book.start_date = row['start_date']
#       book.end_date = row['end_date']
#       book.instance_variable_set(:@id, row['id'])
#       book
#     end
#   end

#   def self.count
#     Database.execute("select count(id) from books")[0][0]
#   end

#   def self.find(id)
#     row = Database.execute("select * from books where id = ?", id).first
#     if row.nil?
#       nil
#     else
#       populate_from_database(row)
#     end
#   end

#   def self.find_by_title(title)
#     row = Database.execute("select * from books where title LIKE ?", title).first
#     if row.nil?
#       nil
#     else
#       populate_from_database(row)
#     end
#   end

#   def valid?
#     if title.nil? or title.empty? or /^\d+$/.match(title)
#       @errors = "\'#{title}\' is not a valid book title."
#       false
#     elsif Book.find_by_title(title)
#       @errors = "\'#{title}\' already exists. Please add a different book."
#       false
#     else
#       @errors = nil
#       true
#     end
#   end

#   def save
#     return false unless valid?
#     if @id.nil?
#       Database.execute("INSERT INTO books (title, topic, ranking, end_date, start_date) VALUES (?,?,?,?,?)", title, topic, ranking, end_date, start_date)
#       @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
#     else
#       Database.execute("UPDATE books SET title=?, topic=?, ranking=?, end_date=?, start_date=? WHERE id=?", title, topic, ranking, end_date, start_date, id)
#       true
#     end
#   end

#   def update
#     Database.execute("UPDATE books SET title=?, topic=?, ranking=?, end_date=?, start_date=? WHERE id=?", title, topic, ranking, end_date, start_date, id)
#       true
#   end

#   private

#   def self.populate_from_database(row)
#     book = Book.new
#     book.title = row['title']
#     book.topic = row['topic']
#     book.ranking = row['ranking']
#     book.start_date = row['start_date']
#     book.end_date = row['end_date']
#     book.instance_variable_set(:@id, row['id'])
#     book
#   end
# end
