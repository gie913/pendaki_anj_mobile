import 'package:pendaki_champion/database/entity/m_species_entity.dart';
import 'package:pendaki_champion/database/helper/database_helper.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/model/table.dart';
import 'package:sqflite/sqflite.dart';

class MSpeciesService {
  void createTableMSpecies(Database db) async {
    await db.execute('''
      CREATE TABLE ${Table.mSpecies}(
       ${MSpeciesEntity.id} TEXT NOT NULL PRIMARY KEY,
       ${MSpeciesEntity.mBioFamilyId} TEXT,
       ${MSpeciesEntity.mBioFamilyName} TEXT,
       ${MSpeciesEntity.mHabitusId} TEXT,
       ${MSpeciesEntity.mHabitusName} TEXT,
       ${MSpeciesEntity.mPrmDietId} TEXT,
       ${MSpeciesEntity.mBioClassId} TEXT,
       ${MSpeciesEntity.mBioClassName} TEXT,
       ${MSpeciesEntity.bioCategory} TEXT, 
       ${MSpeciesEntity.mCompanyCode} TEXT, 
       ${MSpeciesEntity.description} TEXT, 
       ${MSpeciesEntity.code} TEXT,
       ${MSpeciesEntity.imageUrl} TEXT,
       ${MSpeciesEntity.cites} TEXT,
       ${MSpeciesEntity.convention} TEXT,
       ${MSpeciesEntity.endemism} TEXT,
       ${MSpeciesEntity.engName} TEXT,
       ${MSpeciesEntity.inaName} TEXT,
       ${MSpeciesEntity.latinName} TEXT,
       ${MSpeciesEntity.iucn} TEXT,
       ${MSpeciesEntity.ncbiCode} TEXT,
       ${MSpeciesEntity.govRulePermenlhk106} TEXT,
       ${MSpeciesEntity.govRulePp} TEXT,
       ${MSpeciesEntity.createdBy} TEXT,
       ${MSpeciesEntity.createdAt} TEXT,
       ${MSpeciesEntity.updatedBy} TEXT,
       ${MSpeciesEntity.updatedAt} TEXT)
    ''');
  }

  Future<int> insertMSpecies(List<MSpecies> object) async {
    Database db = await DatabaseHelper().database;
    int count = 0;
    for (int i = 0; i < object.length; i++) {
      int saved = await db.insert(Table.mSpecies, object[i].toJson());
      count = count + saved;
    }
    return count;
  }

  Future<List<MSpecies>> selectMSpecies() async {
    List<MSpecies> list = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.query(Table.mSpecies);
    for (int i = 0; i < mapList.length; i++) {
      MSpecies mSpecies = MSpecies.fromJson(mapList[i]);
      list.add(mSpecies);
    }
    return list;
  }

  void deleteMSpecies() async {
    Database db = await DatabaseHelper().database;
    db.delete(Table.mSpecies);
  }
}
