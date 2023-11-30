import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/models/rickandmorty.dart';
import 'package:flutter_rickandmorty/screens/rickandmorty_list.dart';
import 'package:flutter_rickandmorty/services/rickandmorty_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchCharacter extends StatefulWidget {
  const SearchCharacter({super.key});

  @override
  State<SearchCharacter> createState() => _SearchCharacterState();
}

class _SearchCharacterState extends State<SearchCharacter> {
  final searchController = TextEditingController();
  final PagingController<int, RickAndMorty> _searchPagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _searchPagingController.addPageRequestListener((pageKey) {
      _fetchSearchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchSearchPage(int pageKey) async {
    try {
      final List<RickAndMorty> searchResults =
          await RickAndMortyService().getByNameAndPage(searchController.text, pageKey);

      final isLastPage = searchResults.length < (_searchPagingController.nextPageKey ?? 0);


      if (isLastPage) {
        _searchPagingController.appendLastPage(searchResults);
      } else {
        final nextPageKey = pageKey + 1;
        _searchPagingController.appendPage(searchResults, nextPageKey);
      }
    } catch (error) {
      _searchPagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.white54,
          ),
          onSubmitted: (value) {
            _searchPagingController.refresh();
          },
        ),
      ),
      body: RickAndMortyList(pagingController: _searchPagingController),
    );
  }
}
