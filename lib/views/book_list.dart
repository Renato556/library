import 'package:flutter/material.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  const BookList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Image.network(
              book.coverUrl,
              width: 50,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.book, size: 50);
              },
            ),
            title: Text(book.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Authors: ${book.authors.join(', ')}',
                  style: const TextStyle(fontSize: 12),
                ),
                if (book.firstPublishYear != null)
                  Text(
                    'Published: ${book.firstPublishYear}',
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
