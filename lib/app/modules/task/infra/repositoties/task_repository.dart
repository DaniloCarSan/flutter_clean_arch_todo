import 'package:cleanarch/app/modules/task/domain/errors/erros.dart';
import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/repositories/task/i_task_repository.dart';
import 'package:cleanarch/app/modules/task/external/datasources/sqflite_datasource.dart';
import 'package:cleanarch/app/modules/task/infra/datasources/i_task_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart' as modular;
import 'package:sqflite/sqflite.dart';

final $BindTaskRepository = modular.Bind.lazySingleton<ITaskRepository>((i) => TaskRepository(i.get<SqliteDataSource>()));

class TaskRepository implements ITaskRepository {

  final ITaskDatasource _datasource;

  TaskRepository(this._datasource);
  
  @override
  Future<Either<TaskCreateFailure, TaskEntity>> create(TaskEntity taskEntity) async {
    try
    {
      taskEntity  = await _datasource.create(taskEntity);

      return Right(taskEntity);
    }
    on DatabaseException catch(e) 
    {

      if(e.isUniqueConstraintError())
      {
        return Left(TaskCreateFailure('The task exists !')); 
      }

      if(e.isNotNullConstraintError())
      {
        return Left(TaskCreateFailure('The field description required !')); 
      }

      return Left(TaskCreateFailure('Error or add task:' + e.toString()));
    }
    catch(e) 
    {
      return Left(TaskCreateFailure('Error or add task'));
    }
  }

  @override
  Future<List<TaskEntity>> list() async {
    return await _datasource.list();
  }

  @override
  Future<Either<TaskUpdateFailure, TaskEntity>> update(TaskEntity taskEntity) async {
    try
    {
      int rowsEffected =  await _datasource.update(taskEntity);

      if(rowsEffected == 0)
      {
        return Left(TaskUpdateFailure('Error or edit task')); 
      }

      return Right(taskEntity);
    }
    catch (e)
    {
      return Left(TaskUpdateFailure('Error or edit task'));
    }
  }

  @override
  Future<Either<TaskUpdateFailure, TaskEntity>> delete(TaskEntity taskEntity) async {
    try
    {
      int rowsEffected =  await _datasource.delete(taskEntity);

      if(rowsEffected == 0)
      {
        return Left(TaskUpdateFailure('Error or remove task')); 
      }

      return Right(taskEntity);
    }
    catch (e)
    {
      return Left(TaskUpdateFailure('Error or remove task'));
    }
  }

}