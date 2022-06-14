import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/errors/erros.dart';
import 'package:dartz/dartz.dart';

abstract class ITaskRepository {
  Future<Either<TaskCreateFailure,TaskEntity>> create(TaskEntity taskEntity);
  Future<List<TaskEntity>> list();
  Future<Either<TaskUpdateFailure,TaskEntity>> update(TaskEntity taskEntity);
  Future<Either<TaskUpdateFailure,TaskEntity>> delete(TaskEntity taskEntity);
}