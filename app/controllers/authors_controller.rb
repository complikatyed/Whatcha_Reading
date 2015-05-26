# require "highline/import"

# class AuthorsController
  
#   def index
#     if Author.count > 0
#       authors = Author.all
#       choose do |menu|
#         menu.prompt = ""
#         author.each do |book|
#           menu.choice(author.name){ action_menu(author) }
#         end
#         menu.choice("Exit author menu")
#       end
#     else
#       say("No authors found. Please add a new author.\n")
#     end
#   end

#   def action_menu(author)
#     say("Would you like to?")
#     choose do |menu|
#       menu.prompt = ""
#       menu.choice("Edit the book's author") do
#         edit(author)
#       end
#       menu.choice("Go to main menu") do
#         exit
#       end
#     end
#   end

#   def add(name)
#     author = Author.new(name.strip)
#     if author.save
#       "\"#{name}\" has been added.\n"
#     else
#       author.errors
#     end
#   end

#   def edit(author)
#     loop do
#       user_input = ask("Enter a new author name:")
#       author.name = user_input.strip
#       if author.save
#         say("Author has been updated to: \"#{author.name}\"")
#         return
#       else
#         say(author.errors)
#       end
#     end
#   end
# end