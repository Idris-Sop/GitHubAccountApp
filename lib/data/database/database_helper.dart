// data/database/database_helper.dart
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:github_account_app/config/app_config.dart';
import 'package:github_account_app/data/models/github_user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConfig.databaseName);
    return await openDatabase(
      path,
      version: AppConfig.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE liked_accounts(
        id INTEGER PRIMARY KEY,
        login TEXT UNIQUE NOT NULL,
        user_data TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertLikedAccount(GitHubUser user) async {
    final db = await database;
    await db.insert(
      'liked_accounts',
      {
        'id': user.id,
        'login': user.login,
        'user_data': jsonEncode(user.toJson()),
        'created_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeLikedAccount(String login) async {
    final db = await database;
    await db.delete(
      'liked_accounts',
      where: 'login = ?',
      whereArgs: [login],
    );
  }

  Future<List<GitHubUser>> getLikedAccounts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'liked_accounts',
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      final userData = maps[i]['user_data'] as String;
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      return GitHubUser.fromJson(userMap);
    });
  }

  Future<bool> isAccountLiked(String login) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'liked_accounts',
      where: 'login = ?',
      whereArgs: [login],
    );
    return result.isNotEmpty;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}