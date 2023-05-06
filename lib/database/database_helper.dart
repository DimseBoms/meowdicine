import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../objects/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, sessionId TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    final Database db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User> getUser() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    if (maps.isEmpty) {
      return const User(name: '', email: '', sessionId: '');
    }
    return User(
      name: maps[0]['name'],
      email: maps[0]['email'],
      sessionId: maps[0]['sessionId'],
    );
  }
}
