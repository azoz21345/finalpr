import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'users.dart';

class SqlDb{
  SqlDb._privateConstructor(); // Name constructor to create instance of database
  static final SqlDb instance = SqlDb._privateConstructor();
  final databaseName = "userdb2.db";

  // Table
  String user = '''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      number TEXT,
      code TEXT
    )
    ''';
  Future<Database> intialDb() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version)async{
      await db.execute(user);
    });
  }

  Future<Users?> loginUser(String n,String c) async{
    final Database db = await intialDb();
    final result = await db.rawQuery(
        "select * from users where number = '${n}' AND code = '${c}'");
    if (result.isNotEmpty) {
      return Users.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> createUser(Users usr) async{
    final Database db = await intialDb();
    return db.rawInsert("INSERT INTO 'users' ('number', 'code') VALUES ('${usr.number}', '${usr.code}')");
  }

  Future<int> deleteUser(Users usr) async{
    final Database db = await intialDb();
    return await db.rawDelete('DELETE FROM users where id =?',['${usr.id}']);
  }

  Future<void> updateUser(Users usr) async {
    final Database db = await intialDb();
    await db.update(
      'users',
      {
        'number': usr.number,
        'code': usr.code,
      },
      where: "id = ?",
      whereArgs: [usr.id],
    );
  }




  // A method that retrieves all the users from the users table.
  Future<List<Users>> getAllUsers() async {
    final Database db = await intialDb();
    List<Map> list = await db.rawQuery('SELECT * FROM users');
    return list.map((usr) => Users.fromMap(usr as Map<String, dynamic>)).toList();
  }
}
