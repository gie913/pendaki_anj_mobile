class AreaGroup {
  String? id;
  String? code;
  String? listData;

  AreaGroup(
      {this.id,
        this.code,
        this.listData});

  AreaGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    listData = json['list_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['list_data'] = this.listData;
    return data;
  }
}