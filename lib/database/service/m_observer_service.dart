import 'package:pendaki_champion/database/entity/m_observer_entity.dart';
import 'package:pendaki_champion/database/helper/database_helper.dart';
import 'package:pendaki_champion/model/m_observer.dart';
import 'package:pendaki_champion/model/table.dart';
import 'package:sqflite/sqflite.dart';

class MObserverService {
  void createTableMObserver(Database db) async {
    await db.execute('''
      CREATE TABLE ${Table.mObserver}(
       ${MObserverEntity.id} TEXT NOT NULL PRIMARY KEY,
       ${MObserverEntity.mUserId} TEXT,
       ${MObserverEntity.name} TEXT, 
       ${MObserverEntity.code} TEXT,
       ${MObserverEntity.type} TEXT,
       ${MObserverEntity.jobCode} TEXT,
       ${MObserverEntity.mCompanyId} TEXT,
       ${MObserverEntity.createdBy} TEXT,
       ${MObserverEntity.createdAt} TEXT,
       ${MObserverEntity.updatedBy} TEXT,
       ${MObserverEntity.updatedAt} TEXT)
    ''');
  }

  Future<int> insertMObserver(List<MObserver> object) async {
    Database db = await DatabaseHelper().database;
    int count = 0;
    for (int i = 0; i < object.length; i++) {
      int saved = await db.insert(Table.mObserver, object[i].toJson());
      count = count + saved;
    }
    return count;
  }

  Future<List<MObserver>> selectMObserver() async {
    List<MObserver> list = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.query(Table.mObserver);
    for (int i = 0; i < mapList.length; i++) {
      MObserver mObserver = MObserver.fromJson(mapList[i]);
      list.add(mObserver);
    }
    return list;
  }

  void deleteMObserver() async {
    Database db = await DatabaseHelper().database;
    db.delete(Table.mObserver);
  }
}
