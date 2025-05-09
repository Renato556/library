// models/book.dart
class Book {
  final String title;
  final List<String> authors;
  final int? coverId;
  final String? firstPublishYear;

  Book({
    required this.title,
    required this.authors,
    this.coverId,
    this.firstPublishYear,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      authors: (json['author_name'] as List?)?.cast<String>() ?? ['Unknown author'],
      coverId: json['cover_i'],
      firstPublishYear: json['first_publish_year']?.toString(),
    );
  }

  String get coverUrl {
    return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
  }
}
