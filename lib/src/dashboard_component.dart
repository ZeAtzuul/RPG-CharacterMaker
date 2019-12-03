
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'character.dart';
import 'CharService.dart';
import 'character_search_component.dart';
import 'Route_paths.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: ['dashboard_component.css'],
  directives: [coreDirectives, CharacterSearchComponent, routerDirectives],
)

class DashboardComponent implements OnInit{
  List<Character> characters;
  final CharService _charService;

  DashboardComponent(this._charService);

  String characterUrl(int id) =>
      RoutePaths.character.toUrl(parameters: {idParam: '$id'});

  @override
  void ngOnInit() async {
    characters = (await _charService.getAll()).skip(1).take(4).toList();
  }
}