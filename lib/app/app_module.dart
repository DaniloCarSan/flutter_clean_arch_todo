import 'package:cleanarch/app/modules/task/task_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/task/external/datasources/sqlite.dart';

class AppModule extends Module {

  @override
  final List<Bind> binds = [
    $BindSqlite
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: TaskModule()),
  ];

}