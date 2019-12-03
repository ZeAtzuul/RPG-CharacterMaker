import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'Route_paths.dart';
import 'character.dart';
import 'CharService.dart';

@Component(
  selector: 'my-character',
  templateUrl: 'Char_List_component.html',
  styleUrls: ['Char_List_component.css'],
  directives: [coreDirectives],
  pipes: [commonPipes],
)

class CharListComponent implements OnInit{
  final CharService _charService;
  final Router _router;
  List<Character> characters;
  Character selected;

  CharListComponent(this._charService, this._router);

  Future<void> _getCharacters() async {
    characters = await _charService.getAll();
  }

  Future<void> add(String name) async {
    name = name.trim();
    if(name.isEmpty) return null;
    characters.add(await _charService.create(name));
    selected = null;
  }

  Future<void> delete(Character character) async {
    await _charService.delete(character.id);
    characters.remove(character);
    if(selected == character) selected = null;
  }

  void ngOnInit() => _getCharacters();

  void onSelect(Character character) => selected = character;

  String _characterUrl(int id) =>
      RoutePaths.character.toUrl(parameters:{idParam: '$id'});

  Future<NavigationResult> gotoDetail() =>
      _router.navigate(_characterUrl(selected.id));
}