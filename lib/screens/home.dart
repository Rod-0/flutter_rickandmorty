import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/screens/rickandmorty_favorite.dart';
import 'package:flutter_rickandmorty/screens/rickandmorty_list.dart';
import 'package:flutter_rickandmorty/screens/search_character.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int _selectedTab = 0;

  final List<Widget> _children = [
    const SearchCharacter(),
    const RickAndMortyFavorite()
  ];

  _changeTab(int index){
    setState(() {
      _selectedTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick And Morty App"),
      ),
      body: _children[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Characters"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          ]),
    );
  }
}