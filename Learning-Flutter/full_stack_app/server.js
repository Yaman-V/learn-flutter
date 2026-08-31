const express = require("express");
const cors = require("cors");
const app = express();

// Middleware
app.use(cors());
app.use(express.json());
let books = [
  { id: 1, title: "Node Basics" },
  { id: 2, title: "Express Guide" },
];

// Homepage
app.get("/", (req, res) => {
  res.send("API is running...");
});

//GET single book
app.get("/books/:id", (req, res) => {
  const book = books.find((b) => b.id == req.params.id);
  res.json(book);
});

//GET all books
app.get("/books", (req, res) => {
  res.json(books);
});

//POST (Create)
app.post("/books", (req, res) => {
  const newBook = { id: books.length + 1, title: req.body.title };
  books.push(newBook);
  res.json(newBook);
});

//PUT (Update)
app.put("/books/:id", (req, res) => {
  const book = books.find((b) => b.id == req.params.id);
  if (book) {
    book.title = req.body.title;
    res.json(book);
  }
});

//DELETE
app.delete("/books/:id", (req, res) => {
  books = books.filter((b) => b.id != req.params.id);
  res.json({ message: "Deleted" });
});

// Start server
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
