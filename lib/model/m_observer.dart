class MObserver {
  String? id;
  String? code;
  String? name;
  String? type;
  String? jobCode;
  String? mUserId;
  String? mCompanyId;
  String? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  MObserver(
      {this.id,
        this.code,
        this.name,
        this.type,
        this.jobCode,
        this.mUserId,
        this.mCompanyId,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  MObserver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    jobCode = json['job_code'];
    mUserId = json['m_user_id'];
    mCompanyId = json['m_company_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['type'] = this.type;
    data['job_code'] = this.jobCode;
    data['m_user_id'] = this.mUserId;
    data['m_company_id'] = this.mCompanyId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}