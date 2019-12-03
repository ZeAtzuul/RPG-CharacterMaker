import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'character.dart';
import 'CharService.dart';
import 'Route_paths.dart';

@Component(
  selector: 'my-character',
  templateUrl: 'character_component.html',
  styleUrls: ['character_component.css'],
  directives: [coreDirectives, formDirectives],
)

class CharComponent implements OnActivate {
  Character character;
  final CharService _charService;
  final Location _location;

  CharComponent(this._charService, this._location);

  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);
    if (id != null) character = await (_charService.get(id));
  }

  Future<void> save() async {
    await _charService.update(character);
    goBack();
  }
  void goBack() => _location.back();
}