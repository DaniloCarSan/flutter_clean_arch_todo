import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/repositories/task/i_task_repository.dart';
import 'package:cleanarch/app/modules/task/infra/repositoties/task_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $BindEditTaskUseCase = Bind.lazySingleton<EditTaskUseCase>((i) => EditTaskUseCase(i.get<TaskRepository>()));

class EditTaskUseCase {

  final ITaskRepository _repository;

  EditTaskUseCase(this._repository);

  call(TaskEntity taskEntity) async {
    return _repository.update(taskEntity);
  }

}