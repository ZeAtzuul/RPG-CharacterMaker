import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'character.dart';

class CharService{
  static final _headers = {'Content-Type': 'application/json'};
  static const _characterUrl = 'api/characters';

  final Client _http;

  CharService(this._http);

  Future<List<Character>> getAll() async {
    try{
      final response = await _http.get(_characterUrl);
      final characters = (_extractData(response) as List)
          .map((json) => Character.fromJson(json))
          .toList();
  return characters;
    } catch(e){
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Exception _handleError(dynamic e){
    print(e);
    return Exception('Server error; cause: $e');
  }

  Future<Character> get(int id) async {
    try{
      final response = await _http.get('$_characterUrl/$id');
      return Character.fromJson(_extractData(response));
    } catch(e) {
      throw _handleError(e);
    }
  }

  Future<Character> create(String name, int STR, int DEX, int CON,
      int INT, int WIS, int CHA) async {
    try{
      final response = await _http.post(_characterUrl,
          headers: _headers, body: json.encode({'name': name}));
      return Character.fromJson(_extractData(response));
    } catch (e){
      throw _handleError(e);
    }
  }

  Future<Character> update(Character character) async {
    try{
      final url = '$_characterUrl/${character.id}';
      final response = await _http.put(url, headers:
          _headers, body: json.encode(character));
      return Character.fromJson(_extractData(response));
    } catch (e){
      throw _handleError(e);
    }
  }

  Future<void> delete(int id) async {
    try{
      final url = '$_characterUrl/$id';
      await _http.delete(url, headers: _headers);
    } catch (e){
      throw _handleError(e);
    }
  }
}