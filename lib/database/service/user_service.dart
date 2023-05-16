import 'package:pendaki_champion/database/entity/user_entity.dart';
import 'package:pendaki_champion/database/helper/database_helper.dart';
import 'package:pendaki_champion/model/table.dart';
import 'package:pendaki_champion/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserService {
  void createTableUser(Database db) async {
    await db.execute('''
      CREATE TABLE ${Table.mUser}(
       ${UserEntity.id} TEXT NOT NULL PRIMARY KEY,
       ${UserEntity.code} TEXT,
       ${UserEntity.name} TEXT,
       ${UserEntity.email} TEXT,
       ${UserEntity.emailVerifiedAt} TEXT,
       ${UserEntity.mRoleId} TEXT,
       ${UserEntity.username} TEXT,
       ${UserEntity.address} TEXT,
       ${UserEntity.gender} TEXT,
       ${UserEntity.rememberToken} TEXT,
       ${UserEntity.mCompanyId} TEXT,
       ${UserEntity.mCompanyCode} TEXT, 
       ${UserEntity.phoneNumber} TEXT,
       ${UserEntity.lastLogin} TEXT,
       ${UserEntity.loginStatus} TEXT,
       ${UserEntity.lastConnected} TEXT,
       ${UserEntity.mOccupationId} TEXT,
       ${UserEntity.mDepartmentId} TEXT,
       ${UserEntity.mMillId} TEXT,
       ${UserEntity.groupName} TEXT,
       ${UserEntity.isActive} TEXT,
       ${UserEntity.createdAt} TEXT,
       ${UserEntity.createdBy} TEXT,
       ${UserEntity.updatedAt} TEXT,
       ${UserEntity.updatedBy} TEXT,
       ${UserEntity.mEstateId} TEXT,
       ${UserEntity.canFilterCompany} TEXT)
       ''');
  }

  Future<int> insertUser(User object) async {
    Database db = await DatabaseHelper().database;
    int count = 0;
    int saved = await db.insert(Table.mUser, object.toJson());
    count = count + saved;
    return count;
  }

  Future<List<User>> selectUser() async {
    List<User> list = [];
    Database db = await DatabaseHelper().database;
    var mapList = await db.query(Table.mUser);
    for (int i = 0; i < mapList.length; i++) {
      User mUser = User.fromJson(mapList[i]);
      list.add(mUser);
    }
    return list;
  }

  void deleteUser() async {
    Database db = await DatabaseHelper().database;
    db.delete(Table.mUser);
  }
}
