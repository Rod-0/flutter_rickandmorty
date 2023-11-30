class RickAndMorty {
  final String name;
  final int id;

  const RickAndMorty({required this.name, required this.id});

  RickAndMorty.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"] ;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  RickAndMorty.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['id'];
}

class RickAndMortyInfo {
  final String name;
  final String status;
  final String species;
  final String gender;
  final Origine origin;

  const RickAndMortyInfo(
      {required this.name,
      required this.status,
      required this.species,
      required this.gender,
      required this.origin});

  RickAndMortyInfo.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        status = json["status"],
        species = json["species"],
        gender = json["gender"],
        origin = Origine.fromJson(json["origin"]);
  //fromMap
  RickAndMortyInfo.fromMap(Map<String,dynamic> map)
    : name = map['name'],
    status = map['status'],
    species = map['species'],
    gender = map['gender'],
    origin = map['origin'];

  
}

class Origine {
  final String name;
  final String img;

  const Origine({required this.name, required this.img});

  Origine.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        img = json["url"];
}
