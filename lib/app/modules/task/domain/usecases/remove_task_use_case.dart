import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/repositories/task/i_task_repository.dart';
import 'package:cleanarch/app/modules/task/infra/repositoties/task_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $BindRemoveTaskUseCase = Bind.lazySingleton<RemoveTaskUseCase>((i) => RemoveTaskUseCase(i.get<TaskRepository>()));

class RemoveTaskUseCase {

  final ITaskRepository _repository;

  RemoveTaskUseCase(this._repository);

  call(TaskEntity taskEntity) async {
    return _repository.delete(taskEntity);
  }

}