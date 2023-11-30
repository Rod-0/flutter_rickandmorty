import 'package:flutter/material.dart';

String getId(String url) {
  String id = RegExp(r'https://rickandmortyapi.com/api/character/([^]*?)/')
      .firstMatch(url)?[1] as String;
  return id;
}

ImageProvider getImage(int id){
  NetworkImage image = NetworkImage("https://rickandmortyapi.com/api/character/avatar/$id.jpeg");
  return image;
}