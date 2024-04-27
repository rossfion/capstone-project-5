import express from "express";
import bodyParser from "body-parser";
import { dirname } from "path";
import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));

import pg from "pg";

const db = new pg.Client({
  user: "postgres",
  host: "localhost",
  database: "booknotes",
  password: "Your Password",
port: 5432, 
});

const app = express();
const port = 3000; 

app.set('view engine', 'ejs');
app.set('views', 'views');

db.connect();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

let items = [];
let listItems = [];
let authors = [];
let publishers = [];
let categories = [];

// display the home page
app.get("/", async (req, res) => {
	try {
		const result = await db.query("SELECT * FROM books ORDER BY book_title");
  items = result.rows;
  res.render("index.ejs", {
	listTitle: "Welcome to BookNotes",
	frontPageText: "This is my interpretation of Capstone Project 5 from Udemy Instructor Dr. Angela Yu's Web Developer Bootcamp. It is inspired by David Siver's own website devoted to documenting all the non-fiction books he has read with some information about them.",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

// sort by most recently read book(s)
app.post("/most-recent", async (req, res) => {
	try {
		const result = await db.query("SELECT * FROM books ORDER BY date_read DESC");
		//console.log(result);
  items = result.rows;
  res.render("index.ejs", {
	listTitle: "Most Recently Read Books",
	frontPageText: "These are the most recently read books. Well, not actually read by these dates. The dates are arbitrary. This project is for demo purposes.",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

// sort by most recently read book(s)
app.post("/title", async (req, res) => {
	try {
		const result = await db.query("SELECT * FROM books ORDER BY date_added DESC");
		//console.log(result);
  items = result.rows;
  res.render("index.ejs", {
	listTitle: "Book Titles",
	frontPageText: "You sorted by Book Title.",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

// get a single book to read more notes on it
app.get("/book/notes/:id", async (req, res) => {
	try {
		const id = parseInt(req.params.id);
		const result = await db.query("SELECT * FROM books INNER JOIN authors ON books.author_id = authors.author_id INNER JOIN publishers ON books.publisher_id = publishers.publisher_id INNER JOIN categories ON books.category_id = categories.category_id WHERE books.book_id = $1", [id]);
		console.log(result);
  items = result.rows;
  const data = {
    listTitle: "View Book",
	welcomeMessage: "Additional information about this book...",
	items: items,
  };
   res.render(__dirname + "/views/book-details.ejs", data); 
  
	}catch(error){
		console.log(error);
	}
  
});

// Display the admin page

app.get("/admin", async (req, res) => {
	try {
		const result = await db.query("SELECT books.*, authors.*, publishers.*, categories.* FROM books LEFT JOIN authors ON books.author_id = authors.author_id LEFT JOIN publishers ON books.publisher_id = publishers.publisher_id LEFT JOIN categories ON books.category_id = categories.category_id ORDER BY books.book_id ASC");
  items = result.rows;
  res.render(__dirname + "/views/admin.ejs", {
	listTitle: "Welcome to the BookNotes Admin Area",
	welcomeMessage: "Manage your items here",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

/////////////////////////////////////////////////////////////////////////

// create functions to populate multiple dropdowns for the new.ejs file

async function getAuthors() {
  const result = await db.query("SELECT * FROM authors");
  authors = result.rows;
  return authors;
}

async function getPublishers() {
  const result = await db.query("SELECT * FROM publishers");
  publishers = result.rows;
  return publishers;
}

async function getCategories() {
  const result = await db.query("SELECT * FROM categories");
  categories = result.rows;
  return categories;
}

//////////////////////////////////////////////////////////////////////

// CRUD functions for the books table

// get authors for dropdown list in new.ejs
app.get("/admin/books/add", async (req, res) => {
	try {
		const getAllAuthors = await getAuthors();
		const getAllPublishers = await getPublishers();
		const getAllCategories = await getCategories();
   res.render(__dirname + "/views/new.ejs", {
	  listTitle: "Add New Book",
	welcomeMessage: "New book form",
	listAuthors: authors,
	listPublishers: publishers,
	listCategories: categories,
  });
  
	}catch(error){
		console.log(error);
	}
  
}); 



// insert into database
app.post("/admin/books/add-book", async (req, res) => {
	const {book_title,
		book_subtitle,
		book_edition,
		author_id,
		publisher_id,
		category_id,
		publication_year,
		book_ISBN,
		book_cover_image,
		date_read,
		book_notes} = req.body;
  try {
    await db.query("INSERT INTO books (book_title,book_subtitle,book_edition,author_id,		publisher_id,category_id,publication_year,book_ISBN,book_cover_image,date_read,book_notes) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) RETURNING (book_id)", [book_title,book_subtitle,book_edition,author_id,publisher_id,category_id,publication_year,book_ISBN,book_cover_image,date_read,book_notes]);
    res.redirect("/admin");
  } catch (err) {
    console.log(err);
  }
});

// GET a specific book by id for editing and display the populated form
app.get("/admin/books/edit/:id", async (req, res) => {
  
	try {
		const id = parseInt(req.params.id);
		/* Note: there is an error in the database. The author and publisher entries of The Web Designer's Handbook are incorrect. Try the left join strategy from line 107 in order to get the full list of authors and publishers */
		const result = await db.query("SELECT * FROM books INNER JOIN authors ON books.author_id = authors.author_id INNER JOIN publishers ON books.publisher_id = publishers.publisher_id INNER JOIN categories ON books.category_id = categories.category_id WHERE books.book_id = $1", [id]);
  items = result.rows;
  const data = {
    listTitle: "Edit Book",
	welcomeMessage: "Edit book form",
	items: items,
  };
   res.render(__dirname + "/views/edit.ejs", data); 
  
	}catch(error){
		console.log(error);
	}
  
}); 

// edit a book
app.post("/admin/books/edit-book/:id", async (req, res) => {
	const id = parseInt(req.params.id);
	const {book_title,
		book_subtitle,
		book_edition,
		author_id,
		publisher_id,
		category_id,
		publication_year,
		book_isbn,
		book_cover_image,
		date_read, 
		book_notes} = req.body;
  try {
    await db.query("UPDATE books SET book_title = ($1),book_subtitle=($2),book_edition=($3),author_id=($4),publisher_id=($5),category_id=($6),publication_year=($7),book_isbn=($8),book_cover_image=($9),date_read=($10),book_notes=($11) WHERE book_id=$12", [book_title,book_subtitle,book_edition,author_id,publisher_id,category_id,publication_year,book_isbn,book_cover_image,date_read,book_notes,id]);
    res.redirect("/admin");
  } catch (err) {
    console.log(err);
  }
});

// delete a book...immediate delete, no intermediary warning
app.post("/admin/books/delete-book", async (req, res) => {
  const id = req.body.delete_book_id;
  try {
    await db.query("DELETE FROM books WHERE book_id = $1", [id]);
    res.redirect("/admin");
  } catch (err) {
    console.log(err);
  }
});

/////////////////////////////////////////////////////////////////////////

// CRUD functions for the publishers table

// Display the admin/publishers page

app.get("/admin/publishers", async (req, res) => {
	try {
		const result = await db.query("SELECT * FROM publishers ORDER BY publisher_id ASC");
  items = result.rows;
  res.render(__dirname + "/views/publishers.ejs", {
	listTitle: "Publishers List",
	welcomeMessage: "Manage your publishers here",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

// display new publisher form
app.get("/admin/publishers/add", async (req, res) => {
	
   res.render(__dirname + "/views/publisher-new.ejs", {
	  listTitle: "Add New Publisher",
	welcomeMessage: "New publisher form",
  });  
}); 

// add a new publisher into database
app.post("/admin/publishers/add-publisher", async (req, res) => {
	const newId = lastId += 1;
	const {publisher_name} = req.body;
  try {
	  await db.query("INSERT INTO publishers (publisher_name) VALUES ($1) RETURNING (publisher_id)", [publisher_name]);
    //await db.query("INSERT INTO publishers (publisher_name) VALUES ($1) ON CONFLICT (publisher_id) DO NOTHING", [publisher_name]);
	// need to be able to use the push function - FIX THIS? Truncated the table via pgAdmin so I could get this working quickly
	lastId = newId;
  publishers.push(publisher_name);
    res.redirect("/admin/publishers");
  } catch (err) {
    console.log(err);
  }
});

// GET a specific publisher by id for editing and display the populated form
app.get("/admin/publishers/edit/:id", async (req, res) => {
  
	try {
		const id = parseInt(req.params.id);
		const result = await db.query("SELECT * FROM publishers WHERE publisher_id = $1", [id]);
  console.log(result.rows);
  items = result.rows;
  const data = {
    listTitle: "Edit Publisher",
	welcomeMessage: "Edit publisher form",
	items: items,
  };
   res.render(__dirname + "/views/publisher-edit.ejs", data); 
  
	}catch(error){
		console.log(error);
	}
  
}); 

// update the publisher
app.post("/admin/publishers/edit-publisher/:id", async (req, res) => {
	const id = parseInt(req.params.id);
	const {publisher_name} = req.body;
  try {
    await db.query("UPDATE publishers SET publisher_name=($1) WHERE publisher_id=$2", [publisher_name,id]);
    res.redirect("/admin/publishers");
  } catch (err) {
    console.log(err);
  }
});

// delete a publisher...immediate delete, no intermediary warning
app.post("/admin/publishers/delete-publisher", async (req, res) => {
  const id = req.body.delete_publisher_id;
  try {
    await db.query("DELETE FROM publishers WHERE publisher_id = $1", [id]);
    res.redirect("/admin/publishers");
  } catch (err) {
    console.log(err);
  }
});
/////////////////////////////////////////////////////////////////////////

// CRUD functions for the categories table

// Display the admin/categories page

app.get("/admin/categories", async (req, res) => {
	try {
		const result = await db.query("SELECT * FROM categories ORDER BY category_id ASC");
  items = result.rows;
  res.render(__dirname + "/views/categories.ejs", {
	listTitle: "Categories List",
	welcomeMessage: "Manage your categories here",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

// display new category form
app.get("/admin/categories/add", async (req, res) => {
	
   res.render(__dirname + "/views/category-new.ejs", {
	  listTitle: "Add New Category",
	welcomeMessage: "New category form",
  });  
}); 

// add a new category into database
app.post("/admin/categories/add-category", async (req, res) => {
	const {category_name} = req.body;
  try {
    await db.query("INSERT INTO categories (category_name) VALUES ($1) RETURNING (category_id)", [category_name]);
	// need to be able to use the push function - FIX THIS? Truncated the table via pgAdmin so I could get this working quickly
    res.redirect("/admin/categories");
  } catch (err) {
    console.log(err);
  }
});

// GET a specific category by id for editing and display the populated form
app.get("/admin/categories/edit/:id", async (req, res) => {
  
	try {
		const id = parseInt(req.params.id);
		const result = await db.query("SELECT * FROM categories WHERE category_id = $1", [id]);
  console.log(result.rows);
  items = result.rows;
  const data = {
    listTitle: "Edit Category",
	welcomeMessage: "Edit category form",
	items: items,
  };
   res.render(__dirname + "/views/category-edit.ejs", data); 
  
	}catch(error){
		console.log(error);
	}
  
}); 

// update the category
app.post("/admin/categories/edit-category/:id", async (req, res) => {
	const id = parseInt(req.params.id);
	const {category_name} = req.body;
  try {
    await db.query("UPDATE categories SET category_name=($1) WHERE category_id=$2", [category_name,id]);
    res.redirect("/admin/categories");
  } catch (err) {
    console.log(err);
  }
});

// delete a category...immediate delete, no intermediary warning
app.post("/admin/categories/delete-category", async (req, res) => {
  const id = req.body.delete_category_id;
  try {
    await db.query("DELETE FROM categories WHERE category_id = $1", [id]);
    res.redirect("/admin/categories");
  } catch (err) {
    console.log(err);
  }
});

/////////////////////////////////////////////////////////////////////////

// CRUD functions for the authors table

// Display the admin/authors page

app.get("/admin/authors", async (req, res) => {
	try {
		const result = await db.query("SELECT * FROM authors ORDER BY author_id ASC");
  items = result.rows;
  res.render(__dirname + "/views/authors.ejs", {
	listTitle: "Authors List",
	welcomeMessage: "Manage your authors here",
    listItems: items,
  });
	}catch(error){
		console.log(error);
	}
  
});

// display new author form
app.get("/admin/authors/add", async (req, res) => {
	
   res.render(__dirname + "/views/author-new.ejs", {
	  listTitle: "Add New Author",
	welcomeMessage: "New author form",
  });  
}); 

// add a new author into database
app.post("/admin/authors/add-author", async (req, res) => {
	const {author_name} = req.body;
  try {
    await db.query("INSERT INTO authors (author_name) VALUES ($1) RETURNING (author_id)", [author_name]);
	// need to be able to use the push function - FIX THIS? Truncated the table via pgAdmin so I could get this working quickly
    res.redirect("/admin/authors");
  } catch (err) {
    console.log(err);
  }
});

// GET a specific author by id for editing and display the populated form
app.get("/admin/authors/edit/:id", async (req, res) => {
  
	try {
		const id = parseInt(req.params.id);
		const result = await db.query("SELECT * FROM authors WHERE author_id = $1", [id]);
  console.log(result.rows);
  items = result.rows;
  const data = {
    listTitle: "Edit Author Information",
	welcomeMessage: "Edit authors form",
	items: items,
  };
   res.render(__dirname + "/views/author-edit.ejs", data); 
  
	}catch(error){
		console.log(error);
	}
  
}); 

// update the author information
app.post("/admin/authors/edit-author/:id", async (req, res) => {
	const id = parseInt(req.params.id);
	const {author_name} = req.body;
  try {
    await db.query("UPDATE authors SET author_name=($1) WHERE author_id=$2", [author_name,id]);
    res.redirect("/admin/authors");
  } catch (err) {
    console.log(err);
  }
});

// delete an author...immediate delete, no intermediary warning
app.post("/admin/authors/delete-author", async (req, res) => {
  const id = req.body.delete_author_id;
  try {
    await db.query("DELETE FROM authors WHERE author_id = $1", [id]);
    res.redirect("/admin/authors");
  } catch (err) {
    console.log(err);
  }
});

app.use((req, res) => {
    // viewsData variable to be passed to the view file
    const viewsData = {
        pageTitle: 'No information found...'
    };
    res.status(404).render(__dirname + "/views/404.ejs", viewsData);
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
