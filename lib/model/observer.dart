import 'company.dart';

class Observer {
  String? id;
  String? code;
  String? name;
  String? description;
  String? jobCode;
  String? phone;
  String? mCompanyId;
  int? isExternal;
  int? isActive;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? refUserId;
  int? totalDiscovery;
  String? companyCode;
  Company? company;

  Observer({
    this.id,
    this.code,
    this.name,
    this.description,
    this.jobCode,
    this.phone,
    this.mCompanyId,
    this.isExternal,
    this.isActive,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.refUserId,
    this.totalDiscovery,
    this.companyCode,
    this.company,
  });

  Observer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    jobCode = json['job_code'];
    phone = json['phone'];
    mCompanyId = json['m_company_id'];
    isExternal = json['is_external'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    refUserId = json['ref_user_id'];
    totalDiscovery = json['total_discovery'];
    companyCode = json['company_code'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['job_code'] = this.jobCode;
    data['phone'] = this.phone;
    data['m_company_id'] = this.mCompanyId;
    data['is_external'] = this.isExternal;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['ref_user_id'] = this.refUserId;
    data['total_discovery'] = this.totalDiscovery;
    data['company_code'] = this.companyCode;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Observer(id: $id, code: $code, name: $name, description: $description, job_code: $jobCode, phone: $phone, m_company_id: $mCompanyId, is_external: $isExternal, ref_user_id: $refUserId, total_discovery: $totalDiscovery, company_code: $companyCode, company: $company)';
  }
}
