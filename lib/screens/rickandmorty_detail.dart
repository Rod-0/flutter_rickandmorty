
import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/models/rickandmorty.dart';
import 'package:flutter_rickandmorty/services/rickandmorty_service.dart';
import 'package:flutter_rickandmorty/utils/functions.dart';

class RickAndMortyDetail extends StatefulWidget {
  const RickAndMortyDetail({super.key, required this.id});
  final int id;

  @override
  State<RickAndMortyDetail> createState() => _RickAndMortyDetailState();
}

class _RickAndMortyDetailState extends State<RickAndMortyDetail> {
  RickAndMortyService? _rickAndMortyService;
  RickAndMortyInfo? _rickAndMortyInfo;

  @override
  void initState() {
    _rickAndMortyService = RickAndMortyService();
    initialize();
    super.initState();
  }

  Future initialize() async {
    _rickAndMortyInfo =
        await _rickAndMortyService!.getRickAndMortyById(widget.id);
    setState(() {
      _rickAndMortyInfo = _rickAndMortyInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = getImage(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Hero(
                tag: widget.id,
                child: Image(image: image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _rickAndMortyInfo?.name ?? "",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _rickAndMortyInfo?.status ?? "",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _rickAndMortyInfo?.species ?? "",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              //center
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20,right: 20),
                  child: Text(
                    "Origin: ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _rickAndMortyInfo?.origin.name ?? "",
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
