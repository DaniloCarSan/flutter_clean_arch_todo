import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity_fileds.dart';
import 'package:cleanarch/app/modules/task/external/datasources/sqlite.dart';
import 'package:cleanarch/app/modules/task/infra/datasources/i_task_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

final $BindSqliteDataSource = Bind.lazySingleton<ITaskDatasource>((i) => SqliteDataSource(i.get()));

class SqliteDataSource implements ITaskDatasource {

  final Sqlite _sqlite;

  SqliteDataSource(this._sqlite);

  @override
  Future<TaskEntity> create(TaskEntity taskEntity) async {

    Database db = await _sqlite.db;

    int code = await db.insert(TaskEntityFields.table, taskEntity.toJsonAddTask());

    taskEntity.setCode(code);
    
    return taskEntity;
  }

  @override
  Future<List<TaskEntity>> list() async {
    
    Database db = await _sqlite.db;

    List<Map<String,dynamic>> maps = await db.query(TaskEntityFields.table);

    List<TaskEntity> taskEntities = [];

    for (var map in maps)
    {
      taskEntities.add(TaskEntity.fromJson(map));
    }

    return taskEntities;
  }

  @override
  Future<int> update(TaskEntity taskEntity) async {
    
    Database db = await _sqlite.db;

    int rowsEffected = await db.update(TaskEntityFields.table, taskEntity.toJsonEditTask(), where: " ${TaskEntityFields.code} = ? ", whereArgs: [
      taskEntity.code
    ]);

    return rowsEffected;
  }

  @override
  Future<int> delete(TaskEntity taskEntity) async {

    Database db = await _sqlite.db;

    int rowsEffected = await db.delete(TaskEntityFields.table, where: " ${TaskEntityFields.code} = ? ", whereArgs: [
      taskEntity.code
    ]);
    
    return rowsEffected;
  }

}