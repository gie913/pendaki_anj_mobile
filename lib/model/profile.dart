import 'observer.dart';

class Profile {
  String? id;
  String? code;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mRoleId;
  String? username;
  String? address;
  String? gender;
  String? rememberToken;
  String? mCompanyId;
  String? phoneNumber;
  String? lastLogin;
  String? loginStatus;
  String? lastConnected;
  String? mOccupationId;
  String? mDepartmentId;
  String? mMillId;
  String? groupName;
  int? isActive;
  String? imageSrc;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? mEstateId;
  bool? canFilterCompany;
  Observer? observer;

  Profile(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mRoleId,
        this.username,
        this.address,
        this.gender,
        this.rememberToken,
        this.mCompanyId,
        this.phoneNumber,
        this.lastLogin,
        this.loginStatus,
        this.lastConnected,
        this.mOccupationId,
        this.mDepartmentId,
        this.mMillId,
        this.groupName,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.mEstateId,
        this.imageSrc,
        this.canFilterCompany,
        this.observer});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mRoleId = json['m_role_id'];
    username = json['username'];
    address = json['address'];
    gender = json['gender'];
    rememberToken = json['remember_token'];
    mCompanyId = json['m_company_id'];
    phoneNumber = json['phone_number'];
    lastLogin = json['last_login'];
    loginStatus = json['login_status'];
    lastConnected = json['last_connected'];
    mOccupationId = json['m_occupation_id'];
    mDepartmentId = json['m_department_id'];
    mMillId = json['m_mill_id'];
    groupName = json['group_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    mEstateId = json['m_estate_id'];
    imageSrc = json['image_src'];
    canFilterCompany = json['can_filter_company'];
    observer = json['observer'] != null
        ? new Observer.fromJson(json['observer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['m_role_id'] = this.mRoleId;
    data['username'] = this.username;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['remember_token'] = this.rememberToken;
    data['m_company_id'] = this.mCompanyId;
    data['phone_number'] = this.phoneNumber;
    data['last_login'] = this.lastLogin;
    data['login_status'] = this.loginStatus;
    data['last_connected'] = this.lastConnected;
    data['m_occupation_id'] = this.mOccupationId;
    data['m_department_id'] = this.mDepartmentId;
    data['m_mill_id'] = this.mMillId;
    data['group_name'] = this.groupName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['m_estate_id'] = this.mEstateId;
    data['image_src'] = this.imageSrc;
    data['can_filter_company'] = this.canFilterCompany;
    if (this.observer != null) {
      data['observer'] = this.observer!.toJson();
    }
    return data;
  }
}