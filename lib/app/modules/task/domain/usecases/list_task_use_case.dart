import 'package:cleanarch/app/modules/task/domain/repositories/task/i_task_repository.dart';
import 'package:cleanarch/app/modules/task/infra/repositoties/task_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $BindListTaskUseCase = Bind.lazySingleton<ListTaskUseCase>((i) => ListTaskUseCase(i.get<TaskRepository>()));

class ListTaskUseCase {

  final ITaskRepository _repository;

  ListTaskUseCase(this._repository);

  call() async {
    return _repository.list();
  }

}