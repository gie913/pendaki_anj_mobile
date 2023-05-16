class Company {
  String? id;
  String? name;
  String? code;
  String? alias;
  String? area;
  String? industry;
  String? address;
  String? phoneNumber;
  int? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? mWorkflowId;
  double? gpsLong;
  double? gpsLat;
  String? email;

  Company(
      {this.id,
        this.name,
        this.code,
        this.alias,
        this.area,
        this.industry,
        this.address,
        this.phoneNumber,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.mWorkflowId,
        this.gpsLong,
        this.gpsLat,
        this.email});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    alias = json['alias'];
    area = json['area'];
    industry = json['industry'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    mWorkflowId = json['m_workflow_id'];
    gpsLong = json['gps_long'];
    gpsLat = json['gps_lat'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['alias'] = this.alias;
    data['area'] = this.area;
    data['industry'] = this.industry;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['m_workflow_id'] = this.mWorkflowId;
    data['gps_long'] = this.gpsLong;
    data['gps_lat'] = this.gpsLat;
    data['email'] = this.email;
    return data;
  }
}