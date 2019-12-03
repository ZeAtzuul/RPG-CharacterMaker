import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'character.dart';

class CharacterSearch{
  final Client _http;

  CharacterSearch(this._http);

  Future<List<Character>> search(String term) async{
    try{
      final response = await _http.get('app/characters/?name=$term');
      return (_extractData(response) as List)
          .map((json) => Character.fromJson(json))
          .toList();
    }catch (e){
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) =>
      json.decode(resp.body)['data'];

  Exception _handleError(dynamic e){
    print(e);
    return Exception('Server error; cause: $e');
  }
}