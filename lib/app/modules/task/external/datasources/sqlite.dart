import 'dart:async';
import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity_fileds.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final $BindSqlite = Bind.factory<Sqlite>((i) => Sqlite(),export: true);

class Sqlite {
 
  Database? _db;

  static const secretKey = "HKcmmoiXMKDBQ4vI";
  static const databaseVersion = 1;

  List<String> tables =[

  ];

  List<String> clearTablesOnLogout = [
 
  ];

  Future<Database> get db async 
  {
    return _db ??= await initDb(databaseVersion);
  }

  Future<String> _databasePath() async 
  {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, "database.db");
  }

  Future<Database> initDb(int version) async 
  {
    String path = await _databasePath();
    return await openDatabase(path, version:version, onCreate: onCreate,onUpgrade: onUpgrade);
  }

  Future deleteDB() async 
  {
    String path = await _databasePath();
    await deleteDatabase(path);
  }

  FutureOr onCreate(Database db, int newerVersion) => _onCreates[newerVersion]!(db);

  final Map<int,Function> _onCreates = {
    1:(Database db) async {

      await db.execute(
        "CREATE TABLE tasks ("
        "${TaskEntityFields.code} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${TaskEntityFields.description} TEXT NOT NULL UNIQUE,"
        "${TaskEntityFields.done} TEXT NOT NULL DEFAULT ${TaskEntityFields.doneNo}"
        ");"
      );

      // ignore: avoid_print
      print("DATABASE CREATE v1");
    },
    2:(Database db) async{

   
      // ignore: avoid_print
      print("DATABASE CREATE v2");
    },
    3:(Database db) async{

   
      // ignore: avoid_print
      print("DATABASE CREATE v3");
    },
  };

  FutureOr<void> onUpgrade(Database db , int oldVersion, int newVersion ) async 
  {
    for (var migration = oldVersion; migration < newVersion; migration++) 
    {
      _onUpgrades["from_version_${migration}_to_version_${migration+1}"]??(db);
    }
  }

  final Map<String,Function> _onUpgrades = {
    'from_version_1_to_version_2':(Database db) async {
      
      // ignore: avoid_print
      print('from_version_1_to_version_2');
    },
    'from_version_2_to_version_3':(Database db) async {
      
      // ignore: avoid_print
      print('from_version_2_to_version_3');
    },
  };

  Future clearAllTables() async 
  {
    try
    {
      var dbs = await db;
      for (String table  in clearTablesOnLogout)
      {
        await dbs.delete(table);
        await dbs.rawQuery("DELETE FROM sqlite_sequence where name='$table'");
      }
      
      // ignore: avoid_print
      print('------ CLEAR ALL TABLE');
    }
    // ignore: empty_catches
    catch(e){}
  }

}