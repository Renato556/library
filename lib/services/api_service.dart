// services/api_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService with ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://openlibrary.org/search.json?q=$query'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final docs = data['docs'] as List<dynamic>;

        _books = docs.map((doc) => Book.fromJson(doc)).toList();
        if (_books.isEmpty) {
          _errorMessage = 'No books found';
        }
      } else {
        _errorMessage = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Connection error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _books = [];
    _errorMessage = '';
    notifyListeners();
  }
}
