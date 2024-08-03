import 'package:book_buddy/books.dart';
import 'package:flutter/material.dart';
import 'library_data.dart';

class Displaybook extends StatefulWidget {
  final Book book;

  Displaybook({Key? key, required this.book}) : super(key: key);

  @override
  State<Displaybook> createState() => _DisplaybookState();
}

class _DisplaybookState extends State<Displaybook> {
  var _currentIndex = 0;
  late bool _isInLibrary;

  @override
  void initState() {
    super.initState();

    _isInLibrary = LibraryData().checker(widget.book);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/search');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/mylibrary');
    }
  }

  void _toggleLibraryStatus() {
    setState(() {
      if (_isInLibrary) {
        LibraryData().removeBook(widget.book);
      } else {
        LibraryData().addBook(widget.book);
      }
      _isInLibrary = !_isInLibrary;
    });
  }

  @override
  Widget build(BuildContext context) {
    var maincolor = const Color.fromRGBO(162, 185, 162, 1);
    var book = widget.book;

    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: maincolor,
        toolbarHeight: 60,
        title: const Text(
          "Book Selected",
          style: TextStyle(color: Colors.white, fontFamily: "Tropikal"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                child: Image.network(
                  book.imageUrl,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color.fromARGB(255, 68, 57, 57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                    onPressed: _toggleLibraryStatus,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isInLibrary ? Icons.remove : Icons.add,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _isInLibrary
                              ? "Remove From Library"
                              : "Add To Library",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    book.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tropikal",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    book.author,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Tropikal",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    book.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                      fontFamily: "Tropikal",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 67, 94, 78),
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
