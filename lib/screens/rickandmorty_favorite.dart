import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/models/rickandmorty.dart';
import 'package:flutter_rickandmorty/repository/rickandmorty_repository.dart';
import 'package:flutter_rickandmorty/utils/functions.dart';

class RickAndMortyFavorite extends StatefulWidget {
  const RickAndMortyFavorite({super.key});

  @override
  State<RickAndMortyFavorite> createState() => _RickAndMortyFavoriteState();
}

class _RickAndMortyFavoriteState extends State<RickAndMortyFavorite> {
  RickAndMortyRepository? _rickAndMortyRepository;
  List<RickAndMorty>? _rickandMorty;

  

  @override
  void initState()  {
    _rickAndMortyRepository = RickAndMortyRepository();
    initialize();
    super.initState();
  }

  initialize() async {
    _rickandMorty = await _rickAndMortyRepository?.getAll() ?? [];
    setState(() {
      _rickandMorty = _rickandMorty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _rickandMorty?.length ?? 0,
        itemBuilder: ((context, index) {
          return GestureDetector(
            child: Card(
              child: ListTile(
                leading: Hero(
                    tag: _rickandMorty?[index].id ?? 1,
                    child: Image(
                        image: getImage(_rickandMorty?[index].id ?? 1))),
                title: Text(_rickandMorty?[index].name ?? ""),
              ),
            ),
          );
        }),
      ),
    );
  }
}
