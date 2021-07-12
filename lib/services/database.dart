import 'package:always_on_clock/models/settings.dart';
import 'package:always_on_clock/shared/config.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static final LocalDB _database = LocalDB.internal();
  factory LocalDB() => _database;
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDBs();
    }
    return _db;
  }

  LocalDB.internal();

  // Settings
  Future<Settings> getSettings() async {
    Database db = await this.db;
    return db.query('settings').then((settings) {
      if (settings.length > 0) {
        return Settings.fromMap(settings[0]);
      }
      addDefaultSettings();
      return Settings.example();
    });
  }

  Future addDefaultSettings() async {
    Database db = await this.db;
    await db.insert(
      'settings',
      Settings.example().toMap(),
    );
  }

  Future updateSettings(Settings settings) async {
    Database db = await this.db;
    await db.update('settings', settings.toMap());
  }

  // Database-related
  String getTypeInDB(dynamic column) {
    if (column is String) {
      return 'TEXT';
    } else if (column is int) {
      return 'INTEGER';
    } else if (column is bool) {
      return 'INTEGER'; // 1 - true, 0 - false
    } else if (column is DateTime) {
      return 'TEXT';
    } else if (column is double) {
      return 'REAL';
    } else if (column is Color) {
      return 'TEXT';
    } else {
      return 'TEXT';
    }
  }

  Future<Database> initializeDBs() async {
    String directory = await getDatabasesPath();

    return await openDatabase('$directory/$LOCAL_DATABASE_FILENAME.db',
        version: 1, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  void _createDB(Database db, int version) {
    Map<String, dynamic> tables = {
      'settings': Settings.example(),
    };

    tables.forEach((tableName, model) async {
      String columnsQuery = '';
      for (MapEntry<String, dynamic> column in model.toMap().entries) {
        columnsQuery += '${column.key} ${getTypeInDB(column.value)}';
        if (column.key == '${tableName[0].toLowerCase()}id') {
          columnsQuery += ' PRIMARY KEY';
        }
        columnsQuery += ', ';
      }
      columnsQuery = columnsQuery.substring(0, columnsQuery.length - 2);
      db.execute('CREATE TABLE $tableName($columnsQuery)');
    });
  }

  void _upgradeDB(Database db, int oldVersion, int newVersion) {}
}
