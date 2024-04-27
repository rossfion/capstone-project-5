# capstone-project-5
The public API used for this project is from the <a href="https://openlibrary.org/dev/docs/api/covers">Open Library Book Covers API</a>.

This Capstone Project (#5) was completed on a ten-year old laptop running Windows 8.1.

It stands to reason, then, that careful decisions had to be made in terms of what software versions I could run.

The most important choice had to do with PostgreSQL. After testing the most recent versions, I settled on version 9.6. I had used PostgreSQL some years ago and this was the version that worked then.

All SQL queries were tested using the DB Browser for SQLite before being ported to PostgreSQL with minor adjustments in terms of the schema.

The foreign keys are currently set to do nothing on deleting/updating. 

Both the front- and backends were developed using my favorite version of Bootstrap (3.3.7). The admin template is also a favorite of mine, particularly version 2.4.2 for Bootstrap 3.

The app uses four tables: authors, publishers, books and categories. These are joined to produce the results on both the home and admin pages.

On consulting the Open Library Book Covers API documentation, I realized that I could do this project without using Axios in order to get the book covers. I simply applied one of its suggestions and added the links to each entry in the database. 

It works!

You might say that I cheated. I would say, to paraphrase Clint Eastwood in the 1986 movie "Heartbreak Ridge", that I adapted and overcame.

This is not to say that I did not give any thought as to how I might implement Axios. One idea that came to me was to use the ISBN as a parameter to be appended to the URL along with the file extension. I haven't tested it, though.

Would the ISBN then serve as the ID? Hmmm...

Until the coding muse returns...

The project is more for demonstration purposes. It doesn't include any of my real thoughts on any of the books I have included. Thus, the use of dummy text.

Also, there is no validation of entries, nor any authorization for getting access to the admin area.

The app has lots of room for further improvements and development and you are invited to take it and develop as you wish.

On the front page, the user is able to do the following:

1. access the Admin section via the navigation bar
2. use the 'More Notes...' button to be taken to a single page featuring the selected book
3. use the 'Sort by...' buttons to sort through the lists by title (ordered by the date the book was added to the database) and by recency (the date the book was read).

The recency dates are arbitrary dates, not real ones.

In the admin section, the user is able to carry out CRUD functions on all tables.

Options for managing the pages are listed in the left sidebar. Menu items use JavaScript dropdowns.

The user is also able to view the main page using the View Home Page link on the navigation bar which opens a separate browser window.

There is a known "bug" with the updating of the books table/page. Feel free to fix it. Hint: check the SQL for the table join on Line... in the server.js file.

Take care with the delete function on all pages in the admin area. There is no warning message. The entry is deleted instantly.

Like the last project, this one has given me some ideas for improving my own work. I am also thinking of building a production version for use on my personal site.

And I think I am beginning to like this stuff!

<strong>Instructions</strong>

Start up your Git Bash or Windows PowerShell. Or your terminal if using an IDE.

Run npm install (or npm i) to install Express, EJS, and Axios.

Remember to add "type": "module", to your package.json if you haven't already done so, or if you get any error messages about this ommission.

Change your port number for pgAdmin if necessary. This happens when you try to load pgAdmin and you get the "Fatal Error" message.

Change your port number for Node/Expressjs if necessary.

Start the server using node server.js or nodemon server.js. 

PS: If there are any files missing (for example, Iconicons), please note that there is an upload limit on Github via the GUI drag and drop. There are over 1,000 items in the Iconicons folder. Good news, though, there is a repo on Github for AdminLTE. 
