import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/repositories/task/i_task_repository.dart';
import 'package:cleanarch/app/modules/task/infra/repositoties/task_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $BindAddTaskUseCase = Bind.lazySingleton<AddTaskUseCase>((i) => AddTaskUseCase(i.get<TaskRepository>()));

class AddTaskUseCase {

  final ITaskRepository _repository;

  AddTaskUseCase(this._repository);

  call(TaskEntity taskEntity) async {
    return _repository.create(taskEntity);
  }

}