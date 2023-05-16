
class Access {
  String? id;
  String? mModuleId;
  String? mRoleId;
  int? canRead;
  int? canCreate;
  int? canUpdate;
  int? canDelete;
  int? isActive;

  Access(
      {this.id,
        this.mModuleId,
        this.mRoleId,
        this.canRead,
        this.canCreate,
        this.canUpdate,
        this.canDelete,
        this.isActive});

  Access.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mModuleId = json['m_module_id'];
    mRoleId = json['m_role_id'];
    canRead = json['can_read'];
    canCreate = json['can_create'];
    canUpdate = json['can_update'];
    canDelete = json['can_delete'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['m_module_id'] = this.mModuleId;
    data['m_role_id'] = this.mRoleId;
    data['can_read'] = this.canRead;
    data['can_create'] = this.canCreate;
    data['can_update'] = this.canUpdate;
    data['can_delete'] = this.canDelete;
    data['is_active'] = this.isActive;
    return data;
  }
}