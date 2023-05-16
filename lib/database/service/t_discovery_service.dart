import 'package:pendaki_champion/database/entity/t_discovery_entity.dart';
import 'package:pendaki_champion/database/entity/t_discovery_image_entity.dart';
import 'package:pendaki_champion/database/helper/database_helper.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/model/table.dart';
import 'package:sqflite/sqflite.dart';

class TDiscoveryService {
  void createTableTDiscovery(Database db) async {
    await db.execute('''
      CREATE TABLE ${Table.tDiscovery}(
       ${TDiscoveryEntity.id} TEXT NOT NULL PRIMARY KEY,
       ${TDiscoveryEntity.code} TEXT,
       ${TDiscoveryEntity.inaName} TEXT,
       ${TDiscoveryEntity.engName} TEXT,
       ${TDiscoveryEntity.latinName} TEXT,
       ${TDiscoveryEntity.mSpeciesId} TEXT,
       ${TDiscoveryEntity.mBioClassId} TEXT,
       ${TDiscoveryEntity.mBioFamilyId} TEXT,
       ${TDiscoveryEntity.mHabitusId} TEXT,
       ${TDiscoveryEntity.bioCategory} TEXT,
       ${TDiscoveryEntity.dateFound} TEXT,
       ${TDiscoveryEntity.totalFound} INT,
       ${TDiscoveryEntity.areaGroup} TEXT,
       ${TDiscoveryEntity.distanceEstimation} INT,
       ${TDiscoveryEntity.observerActivity} TEXT,
       ${TDiscoveryEntity.description} TEXT,
       ${TDiscoveryEntity.area} TEXT,
       ${TDiscoveryEntity.gpsLng} TEXT,
       ${TDiscoveryEntity.gpsLat} TEXT,
       ${TDiscoveryEntity.createdAt} TEXT,
       ${TDiscoveryEntity.createdBy} TEXT,
       ${TDiscoveryEntity.updatedAt} TEXT,
       ${TDiscoveryEntity.updatedBy} TEXT)
    ''');
  }

  Future<int> insertTDiscovery(TDiscovery object) async {
    Database db = await DatabaseHelper().database;
    int saved = await db.insert(Table.tDiscovery, object.toJson());
    return saved;
  }

  Future<List<TDiscovery>> selectTDiscovery() async {
    List<TDiscovery> list = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.query(Table.tDiscovery);
    for (int i = 0; i < mapList.length; i++) {
      TDiscovery tDiscovery = TDiscovery.fromJson(mapList[i]);
      list.add(tDiscovery);
    }
    return list;
  }

  Future<List<TDiscovery>> selectTDiscoveryWithImage() async {
    List<TDiscovery> list = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.rawQuery("SELECT a.*,(SELECT b.${TDiscoveryImageEntity.url} FROM ${Table.tDiscoveryImage} b Where b.${TDiscoveryImageEntity.tDiscoveryId}= a.${TDiscoveryEntity.id} limit 1) as image from t_discovery a");
    for (int i = 0; i < mapList.length; i++) {
      TDiscovery tDiscovery = TDiscovery.fromJson(mapList[i]);
      list.add(tDiscovery);
    }
    return list;
  }

  Future<int> deleteTDiscoveryByID(TDiscovery tDiscovery) async {
    Database db = await DatabaseHelper().database;
    int i = 0;
    i = await db.delete(Table.tDiscovery,
        where: "${TDiscoveryEntity.id}=?", whereArgs: [tDiscovery.id]);
    return i;
  }

  void deleteTDiscovery() async {
    Database db = await DatabaseHelper().database;
    db.delete(Table.tDiscovery);
  }
}
