import 'package:flutter_logique/data/model/response/posts/my_post.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _favoriteTable = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/myPosts.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favoriteTable (
             id TEXT PRIMARY KEY,
             image TEXT,
             likes INTEGER,
             tags TEXT,
             text TEXT,
             publishDate TEXT,
             owner TEXT
           )     
        ''');
      },
      version: 2,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(MyPost post) async {
    final db = await database;
    await db!.insert(_favoriteTable, post.toJson());
  }

  Future<List<MyPost>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favoriteTable);

    return results.map((res) => MyPost.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
