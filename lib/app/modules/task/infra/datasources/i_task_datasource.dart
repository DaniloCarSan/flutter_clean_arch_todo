import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';

abstract class ITaskDatasource {
  Future<TaskEntity> create(TaskEntity taskEntity);
  Future<List<TaskEntity>> list();
  Future<int> update(TaskEntity taskEntity);
  Future<int> delete(TaskEntity taskEntity);
}