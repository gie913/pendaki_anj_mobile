import 'package:pendaki_champion/model/m_species.dart';

class SpeciesResponse {
  bool? success;
  String? message;
  List<MSpecies>? data;

  SpeciesResponse({this.success, this.message, this.data});

  SpeciesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MSpecies>[];
      json['data'].forEach((v) {
        data!.add(new MSpecies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
