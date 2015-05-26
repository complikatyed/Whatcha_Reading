# class Genre < ActiveRecord::Base
#   attr_reader :id, :errors
#   attr_accessor :name

#   def initialize(name = nil)
#     self.name = name
#   end

#   def ==(other)
#     other.is_a?(Genre) && other.id == self.id
#   end

#   def self.all
#     Database.execute("select * from genres order by name ASC").map do |row|
#       populate_from_database(row)
#     end
#   end

#   def self.count
#     Database.execute("select count(id) from genres")[0][0]
#   end

#   def self.find(id)
#     row = Database.execute("select * from genres where id = ?", id).first
#     if row.nil?
#       nil
#     else
#       populate_from_database(row)
#     end
#   end

#   def valid?
#     if name.nil? or name.empty? or /^\d+$/.match(name)
#       @errors = "\'#{name}\' is not a valid genre name."
#       false
#     else
#       @errors = nil
#       true
#     end
#   end

#   def save
#     return false unless valid?
#     if @id.nil?
#       Database.execute("INSERT INTO genres (name) VALUES (?)", name)
#       @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
#       true
#     else
#       Database.execute("UPDATE genres SET name=? WHERE id=?", name, id)
#       true
#     end
#   end

# 	  private

#   def self.populate_from_database(row)
#     genre = Genre.new
#     genre.title = row['name']
#     genre.instance_variable_set(:@id, row['id'])
#     genre
#   end
# end