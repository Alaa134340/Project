import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1;
  TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];
  List<Book> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    _books = await loadBooks();
    print("Books loaded: ${_books.length}");
    if (_books.isNotEmpty) {
      print("First book title: ${_books[0].title}");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/mylibrary');
    }
  }

  void _onSubmit() {
    String query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredBooks = _books.where((book) {
        final match = book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query) ||
            book.genre.toLowerCase().contains(query);
        if (match) {
          print("Match found: ${book.title}");
        }
        return match;
      }).toList();
    });
    print("Filtered books count: ${_filteredBooks.length}");
  }

  @override
  Widget build(BuildContext context) {
    var maincolor = const Color.fromRGBO(162, 185, 162, 10);
    return Scaffold(
      appBar: AppBar(
        leading: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.menu_book_rounded,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
        backgroundColor: maincolor,
        toolbarHeight: 55,
        title: const Text(
          "Search For Books",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: "Tropikal"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CupertinoSearchTextField(
                    borderRadius: BorderRadius.circular(8.0),
                    controller: _searchController,
                  ),
                ),
                Container(
                  height: 36,
                  width: 40,
                  child: CupertinoButton(
                    onPressed: _onSubmit,
                    child: const Icon(Icons.search, size: 18),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color.fromARGB(255, 67, 94, 78),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_filteredBooks.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = _filteredBooks[index];
                    return ListTile(
                      leading: Image.network(
                        book.imageUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () {},
                    );
                  },
                ),
              )
            else if (_searchController.text.isNotEmpty)
              const Expanded(
                child: Center(
                  child: Text("No results found."),
                ),
              ),
            const SizedBox(height: 20),
            if (_filteredBooks.isEmpty && _searchController.text.isEmpty)
              Row(
                children: [
                  const Text(
                    "Browse Genres",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            const SizedBox(height: 20),
            if (_filteredBooks.isEmpty && _searchController.text.isEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 67, 94, 78),
        backgroundColor: maincolor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'My Library',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 231, 226, 226).withOpacity(0.5),
            child: Center(
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 67, 94, 78),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> categories = [
  "Art",
  "Biography & Autobiography",
  "Business & Economics",
  "Children's Books",
  "Comics & Graphic Novels",
  "Computers",
  "Cooking",
  "Crafts & Hobbies",
  "Drama",
  "Education",
  "Family & Relationships",
  "Fiction",
  "Foreign Language Study",
  "Games & Activities",
  "Gardening",
  "Health & Fitness",
  "History",
  "House & Home",
  "Humor",
  "Juvenile Fiction",
  "Juvenile Nonfiction",
  "Language Arts & Disciplines",
  "Law",
  "Literary Collections",
  "Literary Criticism",
  "Mathematics",
  "Medical",
  "Music",
  "Nature",
  "Performing Arts",
  "Pets",
  "Philosophy",
  "Photography",
  "Poetry",
  "Political Science",
  "Psychology",
  "Reference",
  "Religion",
  "Science",
  "Self-Help",
  "Social Science",
  "Sports & Recreation",
  "Study Aids",
  "Technology & Engineering",
  "Transportation",
  "Travel",
];

class Book {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String genre;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.genre,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>;
    final authors = (volumeInfo['authors'] as List<dynamic>?)
            ?.map((author) => author as String)
            .join(', ') ??
        'Unknown Author';
    final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;

    return Book(
      title: volumeInfo['title'] as String? ?? 'No Title Available',
      author: authors,
      description:
          volumeInfo['description'] as String? ?? 'No Description Available',
      imageUrl: imageLinks?['thumbnail'] as String? ??
          'https://via.placeholder.com/150',
      genre: json['genre'] as String? ?? 'Unknown Genre',
    );
  }
}

Future<List<Book>> loadBooks() async {
  try {
    final jsonString = await rootBundle.loadString('assets/genre_books.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    List<Book> books = [];
    jsonData.forEach((key, value) {
      final List<dynamic> bookList = value as List<dynamic>;
      books.addAll(bookList.map<Book>((json) => Book.fromJson(json)));
    });

    print("Total books loaded: ${books.length}");
    return books;
  } catch (e) {
    print("Error loading books: $e");
    return [];
  }
}
