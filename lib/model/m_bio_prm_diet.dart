class MBioPrmDiet {
  String? id;
  String? code;
  String? name;
  String? description;
  String? mBioFamilyId;
  String? bioCategory;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  MBioPrmDiet(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.mBioFamilyId,
        this.bioCategory,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  MBioPrmDiet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    mBioFamilyId = json['m_bio_family_id'];
    bioCategory = json['bio_category'];
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
    data['description'] = this.description;
    data['m_bio_family_id'] = this.mBioFamilyId;
    data['bio_category'] = this.bioCategory;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}