import 'package:flutter_logique/data/model/response/friend/friend.dart';
import 'package:sqflite/sqflite.dart';


class DbFriendHelper {
  static DbFriendHelper? _instance;
  static Database? _database;

  DbFriendHelper._internal() {
    _instance = this;
  }

  factory DbFriendHelper() => _instance ?? DbFriendHelper._internal();

  static const String _friendsTable = 'friends';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/myFriends.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_friendsTable (
             id TEXT PRIMARY KEY,
             name TEXT
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

  Future<void> addFriend(Friend post) async {
    final db = await database;
    await db!.insert(_friendsTable, post.toJson());
  }

  Future<List<Friend>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_friendsTable);

    return results.map((res) => Friend.fromJson(res)).toList();
  }

  Future<Map> getFriendById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _friendsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFriend(String id) async {
    final db = await database;

    await db!.delete(
      _friendsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
