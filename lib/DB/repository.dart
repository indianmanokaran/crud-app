import 'package:crud_flutter/DB/DbConnection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

//   insert user
  InsertData(table, data) async {
    print("************************************************************************");
    print(table);
    print(data);
    var connection = await database;
    return await connection?.insert(table, data);
  }

//     Read Data all

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }
//     Read Data all
  readDataById(table,id) async {
    var connection = await database;
    return await connection?.query(table,where: 'id=?',whereArgs:[id]);
  }
//   update data

updateData(table,data) async{
    var connection=await database;
    return await connection?.update(table, data,where: 'id=?',whereArgs: [data['id']]);
}
deleteUser(table,id) async{
    var connections=await database;
    return await connections?.rawDelete("delete from $table where id=$id");
}
}