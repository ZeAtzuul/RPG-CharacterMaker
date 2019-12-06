import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'src/character.dart';

class InMemoryDataService extends MockClient {
  static final _initialCharacters = [
    {'id': 1, 'STR': 8,  'DEX': 16, 'CON': 16, 'INT': 20,
      'WIS': 12, 'CHA': 14, 'name': 'Szaaka', 'class':'Wizard'},

    {'id': 2, 'STR': 8,  'DEX': 14, 'CON': 15, 'INT': 20,
      'WIS': 14, 'CHA': 20, 'name': 'Talius', 'class':'Warlock'},

    {'id': 3, 'STR': 6,  'DEX': 20, 'CON': 14, 'INT': 8,
      'WIS': 14, 'CHA': 15, 'name': 'Kogmarde', 'class':'Rogue'},

    {'id': 4, 'STR': 20,  'DEX': 16, 'CON': 20, 'INT': 8,
      'WIS': 14, 'CHA': 8, 'name': 'Kor', 'class':'Barbarian'},

    {'id': 5, 'STR': 8,  'DEX': 18, 'CON': 16, 'INT': 16,
      'WIS': 8, 'CHA': 20, 'name': 'Clyde', 'class':'Sorcerer'},
  ];
  static List<Character> _charactersDb;
  static int _nextId;

  static Future<Response> _handler(Request request) async {
    if (_charactersDb == null) resetDb();
    var data;
    switch (request.method) {
      case 'GET':
        final id = int.tryParse(request.url.pathSegments.last);
        if (id != null) {
          data = _charactersDb
              .firstWhere((character) => character.id == id);
        } else {
          String prefix = request.url.queryParameters['name'] ?? '';
          final regExp = RegExp(prefix, caseSensitive: false);
          data = _charactersDb.where((character) =>
              character.name.contains(regExp)).toList();
        }
        break;
      case 'POST':
        var name = json.decode(request.body)['name'];
        var cclass = json.decode(request.body)['class'];
        var STR = json.decode(request.body)['STR'];
        var DEX = json.decode(request.body)['DEX'];
        var CON = json.decode(request.body)['CON'];
        var INT = json.decode(request.body)['INT'];
        var WIS = json.decode(request.body)['WIS'];
        var CHA = json.decode(request.body)['CHA'];
        var newCharacter = Character(_nextId++, STR, DEX, CON,
            INT, WIS, CHA, name, cclass);
        _charactersDb.add(newCharacter);
        data = newCharacter;
        break;
      case 'PUT':
        var characterChanges = Character.fromJson(json.decode(request.body));
        var targetCharacter = _charactersDb.firstWhere
          ((h) => h.id == characterChanges.id);
        targetCharacter.name = characterChanges.name;
        data = targetCharacter;
        break;
      case 'DELETE':
        var id = int.parse(request.url.pathSegments.last);
        _charactersDb.removeWhere((character) => character.id == id);
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return Response(json.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }
  static resetDb() {
    _charactersDb = _initialCharacters.map((json) =>
        Character.fromJson(json)).toList();
    _nextId = _charactersDb.map((character) =>
    character.id).fold(0, max) + 1;
  }

  static String lookUpName(int id) =>
      _charactersDb.firstWhere((character) =>
      character.id == id, orElse: null)?.name;
  InMemoryDataService() : super(_handler);
}

