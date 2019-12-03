import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:stream_transform/stream_transform.dart';

import 'Route_paths.dart';
import 'character_search.dart';
import 'character.dart';

@Component(
  selector: 'character-search',
  templateUrl: 'character_search_component.html',
  styleUrls: ['character_search_component.css'],
  directives: [coreDirectives, routerDirectives],
  providers: [ClassProvider(CharacterSearch)],
  pipes: [commonPipes],
)

class CharacterSearchComponent implements OnInit {
  CharacterSearch _characterSearch;
  Router _router;

  Stream<List<Character>> characters;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();

  CharacterSearchComponent(this._characterSearch, this._router) {}

  void search(String term) => _searchTerms.add(term);

  void ngOnInit() async {
    characters = _searchTerms.stream
        // ignore: deprecated_member_use
        .transform(debounce(Duration(milliseconds: 300)))
        .distinct()
        // ignore: deprecated_member_use
        .transform(switchMap((term) => term.isEmpty
        ? Stream<List<Character>>.fromIterable([<Character>[]])
        : _characterSearch.search(term).asStream()))
        .handleError((e) {
      print(e);
    });
  }
  String _characterUrl(int id) =>
      RoutePaths.character.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> gotoDetail(Character character) =>
      _router.navigate(_characterUrl(character.id));
}