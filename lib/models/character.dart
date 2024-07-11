class Character {
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;

  const Character(
      {required this.name,
      required this.image,
      required this.gender,
      required this.species,
      required this.status});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        name: json["name"],
        image: json["image"],
        status: json['status'],
        species: json['species'],
        gender: json['gender']);
  }
}
