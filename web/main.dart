import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:DnD_Character_Creator/app_component.template.dart' as ng;
import 'package:DnD_Character_Creator/in_memory_data_service.dart';
import 'package:http/http.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash,
  ClassProvider(Client, useClass: InMemoryDataService),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
