class Character {
  int id, STR, DEX, CON, INT, WIS, CHA;
  String name, cclass;

  Character(this.id, this.STR, this.DEX, this.CON, this.INT,
      this.WIS, this.CHA, this.name, this.cclass);

  factory Character.fromJson(Map<String, dynamic> character) =>
      Character(_toInt(character['id']),
          _toInt(character['STR']), _toInt(character['DEX']),
          _toInt(character['CON']), _toInt(character['INT']),
          _toInt(character['WIS']), _toInt(character['CHA']),
          character['name'], character['class']);

  Map toJson() => {'id':id, 'STR':STR, 'DEX':DEX, 'CON':CON, 'INT':INT,
    'WIS':WIS, 'CHA':CHA, 'name':name, 'class':cclass};

}

int _toInt(id) => id is int ? id : int.parse(id);