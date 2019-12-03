import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths{
  static final characters = RoutePath(path: 'characters');
  static final search = RoutePath(path: 'search');
  static final character = RoutePath(path: '${characters.path}/:$idParam');
}

int getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id == null ? null : int.tryParse(id);
}

