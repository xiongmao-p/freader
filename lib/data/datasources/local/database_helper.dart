import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 2;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE book_sources ADD COLUMN sourceType INTEGER NOT NULL DEFAULT 0
      ''');
    }
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE book_sources (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        rules TEXT NOT NULL,
        sourceType INTEGER NOT NULL DEFAULT 0,
        isEnabled BOOLEAN NOT NULL,
        lastUpdated INTEGER NOT NULL,
        createdAt INTEGER NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookName TEXT NOT NULL,
        author TEXT,
        coverUrl TEXT,
        intro TEXT,
        bookUrl TEXT NOT NULL,
        sourceId INTEGER NOT NULL,
        lastChapterTitle TEXT,
        currentChapterId INTEGER,
        readingProgress REAL NOT NULL,
        addedAt INTEGER NOT NULL,
        lastReadPosition REAL NOT NULL DEFAULT 0.0,
        FOREIGN KEY (sourceId) REFERENCES book_sources (id)
      )
      ''');
    await db.execute('''
      CREATE TABLE chapters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookId INTEGER NOT NULL,
        chapterIndex INTEGER NOT NULL,
        title TEXT NOT NULL,
        url TEXT NOT NULL,
        contentCachedPath TEXT,
        isRead BOOLEAN NOT NULL,
        FOREIGN KEY (bookId) REFERENCES books (id)
      )
      ''');
    await db.execute('''
      CREATE TABLE tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
      ''');
    await db.execute('''
      CREATE TABLE book_tags (
        bookId INTEGER NOT NULL,
        tagId INTEGER NOT NULL,
        PRIMARY KEY (bookId, tagId),
        FOREIGN KEY (bookId) REFERENCES books (id),
        FOREIGN KEY (tagId) REFERENCES tags (id)
      )
      ''');
  }
}
