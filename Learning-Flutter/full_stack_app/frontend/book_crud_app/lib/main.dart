import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books CRUD',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const BooksPage(),
    );
  }
}

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final String apiUrl = "http://10.0.2.2:5000/books";

  List books = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  // GET: Fetch all books
  Future<void> getBooks() async {
    setState(() => loading = true);

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          books = jsonDecode(response.body);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() => loading = false);
  }

  // POST: Add a new book
  Future<void> addBook(String title) async {
    await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title}),
    );

    getBooks();
  }

  // PUT: Update an existing book
  Future<void> updateBook(int id, String title) async {
    await http.put(
      Uri.parse("$apiUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title}),
    );

    getBooks();
  }

  // DELETE: Delete a book
  Future<void> deleteBook(int id) async {
    await http.delete(Uri.parse("$apiUrl/$id"));

    getBooks();
  }

  // Show Add/Edit Book Dialog
  void showBookDialog({Map? book}) {
    final controller = TextEditingController(text: book?["title"] ?? "");

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(book == null ? "Add Book" : "Edit Book"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Book Title",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isEmpty) {
                  return;
                }

                if (book == null) {
                  await addBook(controller.text);
                } else {
                  await updateBook(book["id"], controller.text);
                }

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Books CRUD App"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showBookDialog(),
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: getBooks,
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(child: Text("${book["id"]}")),

                      title: Text(book["title"]),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit button
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => showBookDialog(book: book),
                          ),

                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteBook(book["id"]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
