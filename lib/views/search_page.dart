import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import 'book_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
    _searchController.addListener(_onTextChanged);
  }

  void _onFocusChange() {
    setState(() {
      _showClearButton =
          _searchFocusNode.hasFocus || _searchController.text.isNotEmpty;
    });
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton =
          _searchController.text.isNotEmpty || _searchFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Open Library Search (Provider)')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Search for books',
                      hintText:
                          _searchFocusNode.hasFocus
                              ? 'Enter title, author, or keywords'
                              : null,
                      border: const OutlineInputBorder(),
                      suffixIcon:
                          _showClearButton
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  apiService.clearSearch();
                                  setState(() {
                                    _showClearButton = false;
                                  });
                                },
                              )
                              : null,
                    ),
                    onSubmitted: (value) {
                      apiService.searchBooks(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      apiService.searchBooks(_searchController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                apiService.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : apiService.errorMessage.isNotEmpty
                    ? Center(child: Text(apiService.errorMessage))
                    : BookList(books: apiService.books),
          ),
        ],
      ),
    );
  }
}
