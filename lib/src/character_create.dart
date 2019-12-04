import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'character.dart';
import 'CharService.dart';
import 'Route_paths.dart';

@Component(
  selector: 'character-create',
  templateUrl: 'character_create.html',
  styleUrls: ['character_create.css'],
  directives: [coreDirectives, formDirectives],
)

class CharacterCreate implements OnActivate{
  Character character;
  final CharService _charService;
  final Location _location;
  Character selected;
  List<Character> characters;

  CharacterCreate(this._charService, this._location);

  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);
    if (id != null) character = await (_charService.get(id));
  }

  Future<void> save() async {
    await _charService.update(character);
    goBack();
  }

  Future<void> add(String name, int STR, int DEX, int CON,
      int INT, int WIS, int CHA) async {
    name = name.trim();
    if(name.isEmpty) return null;
    characters.add(await _charService.create(name, STR, DEX, CON,
        INT, WIS, CHA));
    selected = null;
  }

  void goBack() => _location.back();
}