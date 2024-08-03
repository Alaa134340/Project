import 'package:book_buddy/sign_in.dart';
import 'package:book_buddy/sign_up.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'myLibrary.dart';
import 'searchpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      routes: {
        '/': (context) => HomePage(),
        '/search': (context) => const SearchPage(),
        '/mylibrary': (context) => const MyLibrary(),
        '/signup': (context) => const SignUp(),
        '/LogIn': (context) => const LogIn(),
      },
    );
  }
}
