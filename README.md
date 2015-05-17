
# Whatcha-Reading
NSS C8 - P2-W4 - Half capstone Ruby

## Project Vision

This will be a small command-line program that asks the user to track the books she's reading.

Users will be able to add book title and author, reading start and end dates, a short plot description, and a mini-review (using a "1-4 stars" format).

## Features

### Adding a book
In order to keep track of the books I'm reading, I want to add a new book information as I begin reading each book.
  * Book Title
  * Book Author
  * Book Genre
  * Start Date (user will be prompted to add this date)
  * Book Rating (will initially be blank)
  * Book Topic (1 sentence description, will initially be blank)
  * End Date (will initially be blank)

Usage:
> `./whatcha_reading add`  
> User answers ADD  
> `Please enter the book's title.`  
> User types in title  
> `Please enter the name of the book's author. (Last, First)`  
> User types in name as Last, First  (e.g., "Austen, Jane")  
> `The author's name is Jane Austen. Y or N?`  
> if user types N, she will be given a prompt to correct the entry  
> `Please try again using this format: Last Name, First Name`
> `The author's name is Jane Austen. Y or N?` 
> if user types Y, the next question prints to screen  
> `Does your book have another author? Y or N?`  
> if user types Y, the first author questions are repeated  
> if user types N, the next question prints to screen  
> `Please enter the book's GENRE`  {Can we do a dropdown menu?}  
> User enters the genre  
> `Please enter a reading start date YY/MM/DD`  
>   Rating, Topic, and End date fields are added automatically  
> Book information prints to the screen  
> `Is this information correct? Y or N?`  
> if user types N, {Need editing commands here - how?}  
> if user types Y, screen prints `"Do you want to add another book?"`  
> if user types N, `EXIT`  
> if user types Y, start over with  
> `Please enter the book's title and subsequent steps`  

Acceptance Criteria:
* The new book title is added to the database and given a unique id number
* The book's author (last name, first name) is added to author table with an author_id number
* The Book_Authors table is updated with book.id and author.id numbers
* The user is given the option to add multiple author names.
* If multiple authors are given, the Book_Authors table is again updated with book.id and author.id for subsequent authors.
* The book's genre.id is added to the book table
* The start date is added to the book record
* A space for a book topic is added
* A space for a star rating is added, but left blank
* A space for an ending date is added, but left blank
* The database and accompanying tables are updated


### Editing an end date

In order to note when I have finished reading a particular book, I want to edit the end date field and add a date.

Usage:
> `./whatcha_reading edit`  
> `What book would you like to edit?`  
> User types in book title  
> Book title prints to screen
> `Is this the book you want to edit? Y or N`
> If user enters Y, move on to next question.  
> If user enters N, reprompt for book title.
> `What information would you like to edit?  TOPIC, RATING, END_DATE`  
> User enters END_DATE  
> `Please enter a reading start date YY/MM/DD`  
> User enters date.  
> `Would you like to continue editing? Y or N?`  
> if user enters N, `EXIT`  
> if user enters Y, go back to `What information would you like to edit? TOPIC, RATING, END_DATE`  

Acceptance Criteria:
* User is asked to enter book title  
* Correct book record is retrieved  
* User adds desired end date  
* The correct book's record is updated to include the new date in the end date field


### Editing a book record to add a topic sentence

In order to remind myself what the book was about, I want to edit the topic field.

> `./whatcha_reading edit`  
> `What book would you like to edit?`  
> User types in book title  
> Book title prints to screen
> `Is this the book you want to edit? Y or N`
> If user enters Y, move on to next question.  
> If user enters N, reprompt for book title.
> `What information would you like to edit?  TOPIC, RATING, END_DATE`  
> User enters TOPIC  
> `Please add your topic sentence (200 char max)`  
> User enters sentence.
> `You entered: book.topic `
> `Would you like to continue editing? Y or N?`  
> if user enters N, `EXIT`  
> if user enters Y, go back to `What information would you like to edit? TOPIC, RATING, END_DATE`  


Acceptance Criteria:
* The book's topic field is updated with a one-sentence description.
* The topic sentence is displayed on screen.
* The user is given the option to continue editing or to exit.


### Adding a mini-review

In order to remind myself of whether I liked the book, I want to add a simple rating from 1 to 5.

Usage:

Usage:
> `./whatcha_reading edit`  
> `What book would you like to edit?`  
> User types in book title  
> Book title prints to screen
> `Is this the book you want to edit? Y or N`
> If user enters Y, move on to next question.  
> If user enters N, reprompt for book title.
> `What information would you like to edit?  TOPIC, RATING, END_DATE`  
> User enters RATING  
> `Please enter a rating from 1 (meh) to 5 (excellent)`  
> User enters number  
> `You gave this book a ranking of #{book.rank}'`  
> `Would you like to continue editing? Y or N?`  
> if user enters N, `EXIT`  
> if user enters Y, go back to `What information would you like to edit? TOPIC, RATING, END_DATE`  

Acceptance Criteria:
* The book's review field is updated to include a rating number from 1 to 5
* The user's book rank prints to the screen.
* The user is given the option to continue editing or exit the program.


### View a list of titles

In order to remind myself of the books I've read, I want to see a list of all titles in the record.

Usage:
> `./whatcha_reading view`  
> `What would you like to view?  BOOK_LIST, AUTHOR_LIST, START_DATES, END_DATES, RANKINGS`  
> User enters BOOK_LIST  
> List of books prints to screen  {what other data?}  
> `Exit`  

Acceptance Criteria:
* All book titles are printed out
* Accompanying data from the each book's record is printed out

### View a list of dates (start or end)

In order to evaluate the volume and speed of my reading, or to determine how many books I've read in a given period of time, I want to print out a list of start dates or end dates.

Usage:
> `./whatcha_reading view`  
> `What would you like to view?  BOOK_LIST, AUTHOR_LIST, START_DATES, END_DATES, RANKINGS`  
> User enters END_DATES  
> List of authors prints to screen  {what other data?}  
> `Exit`  

Acceptance Criteria:
* All book titles are printed out
* Titles are printed in order of the end date

### View a list of books based on ranking

In order to recommend books for other readers, I want to be able to see the books I've read in order of their ranking.

Usage:
> `./whatcha_reading view`  
> `What would you like to view?  BOOK_LIST, AUTHOR_LIST, START_DATES, END_DATES, RANKINGS`  
> User enters RANKINGS 
> List of books prints to screen by rankings  {what else prints to screen?} 
> `Exit` 

Acceptance Criteria:
* All book titles are printed out
* Titles are printed in order of their ranking number
