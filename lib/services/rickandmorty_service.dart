import 'dart:io';
import 'dart:convert';
import 'package:flutter_rickandmorty/models/rickandmorty.dart';
import 'package:http/http.dart' as http;

class RickAndMortyService{
  final baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<RickAndMorty>> getAll(int page) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)["results"];
      final List<RickAndMorty> items =
          data.map((dynamic item) => RickAndMorty.fromJson(item)).toList();
      return items;
    } else {
      throw Exception('Failed to load data!');
      
      
    }
  }

  //getRickAndMortyById
  Future <RickAndMortyInfo?> getRickAndMortyById(int id) async{
    http.Response response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final rickandmortyInfo = RickAndMortyInfo.fromJson(jsonResponse);
      return rickandmortyInfo;
    }
    return null;
  }

  //getByName
  Future<List<RickAndMorty>> getByNameAndPage(String name, int page) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?name=$name&page=$page'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)["results"];
        final List<RickAndMorty> items =
            data.map((dynamic item) => RickAndMorty.fromJson(item)).toList();
        return items;
      } else {
        print('API error: ${response.statusCode}, ${response.reasonPhrase}');
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Failed to load data!');
    }
  }
}