import 'package:angular_router/angular_router.dart';

import 'Route_paths.dart';
import 'Char_List_component.template.dart' as char_list_template;
import 'dashboard_component.template.dart' as dashboard_template;
import 'character_component.template.dart' as character_template;

export 'Route_paths.dart';

class Routes{
  static final dashboard = RouteDefinition(
    routePath: RoutePaths.dashboard,
    component: dashboard_template.DashboardComponentNgFactory,
  );

  static final characters = RouteDefinition(
    routePath: RoutePaths.characters,
    component: char_list_template.CharListComponentNgFactory
  );

  static final character = RouteDefinition(
    routePath: RoutePaths.character,
    component: character_template.CharComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    dashboard,
    characters,
    character,
    RouteDefinition.redirect(
      path:'',
      redirectTo: RoutePaths.dashboard.toUrl(),
    ),
  ];
}
