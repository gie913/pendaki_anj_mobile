
import 'package:pendaki_champion/model/user.dart';

import 'access.dart';

class Data {
  String? token;
  String? tokenExpiredAt;
  User? user;
  List<Access>? access;

  Data({this.token, this.tokenExpiredAt, this.user, this.access});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenExpiredAt = json['token_expired_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['access'] != null) {
      access = <Access>[];
      json['access'].forEach((v) {
        access!.add(new Access.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['token_expired_at'] = this.tokenExpiredAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.access != null) {
      data['access'] = this.access!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
