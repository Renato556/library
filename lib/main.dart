// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/search_page.dart';
import 'services/api_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Library Search (Provider)',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SearchPage(),
    );
  }
}
