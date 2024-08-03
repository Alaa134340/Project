import 'dart:convert';
import 'package:flutter/services.dart';

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
  final jsonString = await rootBundle.loadString('assets/genre_books.json');
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  List<Book> books = [];
  jsonData.forEach((key, value) {
    final List<dynamic> bookList = value as List<dynamic>;
    books.addAll(bookList.map<Book>((json) => Book.fromJson(json)));
  });

  return books;
}
