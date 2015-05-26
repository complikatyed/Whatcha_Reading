# require "highline/import"

# class GenresController

#   def genres_menu(genre)
#     say("Please choose a genre:")
#     choose do |menu|
#       menu.prompt = ""
#       menu.choice("Sci-Fi/Fantasy") do
#         genre.add
#         exit
#       end
#       menu.choice("18th-19th century realism") do
#         genre.add
#         exit
#       end
#       menu.choice("Modern realism") do
#         genre.add
#         exit
#       end
#       menu.choice("Mystery/Thriller") do
#         genre.add
#         exit
#       end
#       menu.choice("Poetry") do
#         genre.add
#         exit
#       end
#       menu.choice("Biography/Memoir") do
#         genre.add
#         exit
#       end
#       menu.choice("Non-fiction") do
#         genre.add
#         exit
#       end
#     end
#   end

#   def add(name)
#     genre = Genre.new(name.strip)
#     if genre.save
#       "\"#{name}\" has been added.\n"
#     else
#       genre.errors
#     end
#   end

#   def edit(genre)
#     loop do
#       user_input = ask("Enter a new genre name:")  # Needs to offer the menu again
#       genre.name = user_input.strip
#       if genre.save
#         say("Genre has been updated to: \"#{genre.name}\"")
#         return
#       else
#         say(genre.errors)
#       end
#     end
#   end
# end