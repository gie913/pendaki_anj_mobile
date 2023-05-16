import 'fauna.dart';

class FaunaList {
  List<Fauna>? fauna;

  FaunaList({this.fauna});

  FaunaList.fromJson(Map<String, dynamic> json) {
    if (json['fauna'] != null) {
      fauna = <Fauna>[];
      json['fauna'].forEach((v) {
        fauna!.add(new Fauna.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fauna != null) {
      data['fauna'] = this.fauna!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}