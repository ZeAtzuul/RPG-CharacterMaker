class Character {
  final int id;
  String name;

  Character(this.id, this.name);

  factory Character.fromJson(Map<String, dynamic> character) =>
      Character(_toInt(character['id']), character['name']);

  Map toJson() => {'id':id, 'name':name};

}

int _toInt(id) => id is int ? id : int.parse(id);