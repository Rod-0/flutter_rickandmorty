import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/models/rickandmorty.dart';
import 'package:flutter_rickandmorty/repository/rickandmorty_repository.dart';
import 'package:flutter_rickandmorty/screens/rickandmorty_detail.dart';
import 'package:flutter_rickandmorty/services/rickandmorty_service.dart';
import 'package:flutter_rickandmorty/utils/functions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RickAndMortyList extends StatefulWidget {
  const RickAndMortyList({super.key, required this.pagingController});
  final PagingController<int, RickAndMorty> pagingController;

  @override
  State<RickAndMortyList> createState() => _RickAndMortyListState();
}

class _RickAndMortyListState extends State<RickAndMortyList> {
  RickAndMortyService? _rickAndMortyService;
  static const _pageSize = 20;

  final PagingController<int, RickAndMorty> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _rickAndMortyService = RickAndMortyService();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<RickAndMorty> newItems = await _rickAndMortyService!.getAll(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

 @override
  Widget build(BuildContext context) {
    return PagedListView<int, RickAndMorty>(
      pagingController: widget.pagingController,
      builderDelegate: PagedChildBuilderDelegate<RickAndMorty>(
        itemBuilder: (context, item, index) => RickAndMortyItem(
          rickAndMorty: item,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class RickAndMortyItem extends StatefulWidget {
  const RickAndMortyItem({super.key, required this.rickAndMorty});
  final RickAndMorty? rickAndMorty;

  @override
  State<RickAndMortyItem> createState() => _RickAndMortyItemState();
}

class _RickAndMortyItemState extends State<RickAndMortyItem> {
  bool isFavorite = false;
  
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    isFavorite =
        await RickAndMortyRepository().isFavorite(widget.rickAndMorty!);
    if (mounted) {
      setState(() {
        isFavorite = isFavorite;
      });
    }
  }

 
  @override
  Widget build(BuildContext context) {
    final image = getImage(widget.rickAndMorty?.id ?? 0);
    final icon =
        Icon(Icons.favorite, color: isFavorite ? Colors.red : Colors.grey);
    final rickAndMorty = widget.rickAndMorty;
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RickAndMortyDetail(id: rickAndMorty?.id ?? 1))),
      child: Card(
          elevation: 5,
          child: ListTile(
            leading: Hero(
              tag: widget.rickAndMorty?.id??'',
              child: Image(image: image),
            ),
            title: Text(rickAndMorty?.name ?? ""),
            trailing: IconButton(
                onPressed: () async {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  isFavorite
                      ? RickAndMortyRepository().insert(rickAndMorty!)
                      : RickAndMortyRepository().delete(rickAndMorty!);
                },
                icon: icon),
          ),
          ),
    );
  }
}
