import 'package:book_buddy/books.dart';

class LibraryData {
  static final LibraryData _instance = LibraryData._internal();

  factory LibraryData() {
    return _instance;
  }

  LibraryData._internal();

  final List<Book> _myLibraryBooks = [];

  List<Book> get myLibraryBooks => _myLibraryBooks;

  void addBook(Book book) {
    _myLibraryBooks.add(book);
  }

  void removeBook(Book book) {
    _myLibraryBooks.remove(book);
  }

  bool checker(Book book) {
    return _myLibraryBooks.contains(book);
  }
}
