import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pendaki_champion/database/service/m_observer_service.dart';
import 'package:pendaki_champion/database/service/m_species_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_image_service.dart';
import 'package:pendaki_champion/database/service/t_discovery_service.dart';
import 'package:pendaki_champion/database/service/user_service.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _dbHelper;
  static Database? _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    _dbHelper ??= DatabaseHelper._createObject();
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'pendaki_champion.db';
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    UserService().createTableUser(db);
    MObserverService().createTableMObserver(db);
    MSpeciesService().createTableMSpecies(db);
    TDiscoveryService().createTableTDiscovery(db);
    TDiscoveryImageService().createTableTDiscoveryImage(db);
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }
}
