class TDiscoveryImage {
  String? id;
  String? code;
  String? tDiscoveryId;
  String? name;
  String? url;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  TDiscoveryImage(
      {this.id,
        this.code,
        this.tDiscoveryId,
        this.name,
        this.url,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  TDiscoveryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['id'];
    tDiscoveryId = json['t_discovery_id'];
    name = json['name'];
    url = json['url'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['t_discovery_id'] = this.tDiscoveryId;
    data['name'] = this.name;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}