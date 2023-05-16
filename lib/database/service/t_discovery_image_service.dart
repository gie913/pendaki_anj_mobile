import 'package:pendaki_champion/database/entity/t_discovery_image_entity.dart';
import 'package:pendaki_champion/database/helper/database_helper.dart';
import 'package:pendaki_champion/model/t_discovery.dart';
import 'package:pendaki_champion/model/t_discovery_image.dart';
import 'package:pendaki_champion/model/table.dart';
import 'package:sqflite/sqflite.dart';

class TDiscoveryImageService {
  void createTableTDiscoveryImage(Database db) async {
    await db.execute('''
      CREATE TABLE ${Table.tDiscoveryImage}(
       ${TDiscoveryImageEntity.id} TEXT NOT NULL PRIMARY KEY,
       ${TDiscoveryImageEntity.code} TEXT,
       ${TDiscoveryImageEntity.url} TEXT,
       ${TDiscoveryImageEntity.name} TEXT,
       ${TDiscoveryImageEntity.tDiscoveryId} TEXT,
       ${TDiscoveryImageEntity.createdBy} TEXT,
       ${TDiscoveryImageEntity.createdAt} TEXT,
       ${TDiscoveryImageEntity.updatedBy} TEXT,
       ${TDiscoveryImageEntity.updatedAt} TEXT)
    ''');
  }

  Future<int> insertTDiscoveryImage(TDiscoveryImage object) async {
    Database db = await DatabaseHelper().database;
    int saved = await db.insert(Table.tDiscoveryImage, object.toJson());
    return saved;
  }

  Future<List<TDiscoveryImage>> selectTDiscoveryImage() async {
    List<TDiscoveryImage> list = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.query(Table.tDiscoveryImage);
    for (int i = 0; i < mapList.length; i++) {
      TDiscoveryImage tDiscoveryImage = TDiscoveryImage.fromJson(mapList[i]);
      list.add(tDiscoveryImage);
    }
    return list;
  }

  Future<int> deleteTDiscoveryImageByID(TDiscovery tDiscovery) async {
    Database db = await DatabaseHelper().database;
    int i = 0;
    i = await db.delete(Table.tDiscoveryImage,
        where: "${TDiscoveryImageEntity.id}=?", whereArgs: [tDiscovery.id]);
    return i;
  }

  void deleteTDiscoveryImage() async {
    Database db = await DatabaseHelper().database;
    db.delete(Table.tDiscoveryImage);
  }
}
