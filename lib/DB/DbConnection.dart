import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  static final DatabaseConnection _instance = DatabaseConnection._internal();

  factory DatabaseConnection() => _instance;

  DatabaseConnection._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await setDatabase();
    return _database!;
  }

  Future<Database> setDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'db_crud');

    _database = await openDatabase(path, version: 1, onCreate: _createTable);
    return _database!;
  }

  Future<void> _createTable(Database database, int version) async {
    final sql = '''
      CREATE TABLE Users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        contact TEXT,
        description TEXT
      );
    ''';
    await database.execute(sql);
  }
}
