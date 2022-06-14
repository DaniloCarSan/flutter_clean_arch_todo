
import 'package:cleanarch/app/modules/task/domain/usecases/add_task_use_case.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/edit_task_use_case.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/list_task_use_case.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/remove_task_use_case.dart';
import 'package:cleanarch/app/modules/task/external/datasources/sqflite_datasource.dart';
import 'package:cleanarch/app/modules/task/infra/repositoties/task_repository.dart';
import 'package:cleanarch/app/modules/task/presenter/pages/task/task_page.dart';
import 'package:cleanarch/app/modules/task/presenter/pages/task/task_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
 
class TaskModule extends Module {

  @override
  final List<Bind> binds = [
    $BindTaskStore,
    $BindAddTaskUseCase,
    $BindTaskRepository,
    $BindSqliteDataSource,
    $BindListTaskUseCase,
    $BindEditTaskUseCase,
    $BindRemoveTaskUseCase,
  ];

  @override
  final List<ModularRoute> routes = [
    $ChildRouteTaskPage
  ];

}