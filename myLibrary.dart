import 'package:flutter/material.dart';
import 'library_data.dart';
import 'displayBook.dart';

class MyLibrary extends StatefulWidget {
  const MyLibrary({super.key});

  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  int _currentIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/search');
    } else if (index == 2) {}
  }

  @override
  Widget build(BuildContext context) {
    var maincolor = const Color.fromRGBO(162, 185, 162, 1);
    return Scaffold(
      appBar: AppBar(
        leading: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: maincolor,
        toolbarHeight: 60,
        title: const Text(
          "My Library",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Tropikal",
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: LibraryData().myLibraryBooks.length,
        itemBuilder: (context, index) {
          final book = LibraryData().myLibraryBooks[index];
          return Container(
            height: 120,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: Image.network(
                book.imageUrl,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Displaybook(book: book),
                  ),
                );
              },
            ),
          );
          ;
        },
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
