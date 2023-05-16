class TDiscovery {
  String? id;
  String? code;
  String? inaName;
  String? engName;
  String? latinName;
  String? mSpeciesId;
  String? mBioClassId;
  String? mBioFamilyId;
  String? mHabitusId;
  String? bioCategory;
  String? dateFound;
  int? totalFound;
  String? image;
  int? distanceEstimation;
  String? observerActivity;
  String? description;
  String? area;
  String? areaGroup;
  dynamic gpsLng;
  dynamic gpsLat;
  String? createdAt;
  String? createdBy;
  String? updateAt;
  String? updateBy;

  TDiscovery(
      {this.id,
        this.code,
        this.inaName,
        this.engName,
        this.latinName,
        this.mSpeciesId,
        this.mBioClassId,
        this.mBioFamilyId,
        this.mHabitusId,
        this.bioCategory,
        this.dateFound,
        this.totalFound,
        this.distanceEstimation,
        this.observerActivity,
        this.description,
        this.area,
        this.areaGroup,
        this.gpsLng,
        this.gpsLat,
      this.createdAt,
      this.createdBy,
      this.updateAt,
      this.updateBy});

  TDiscovery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['id'];
    inaName = json['ina_name'];
    engName = json['eng_name'];
    image = json['image'];
    latinName = json['latin_name'];
    mSpeciesId = json['m_species_id'];
    mBioClassId = json['m_bio_class_id'];
    mBioFamilyId = json['m_bio_family_id'];
    mHabitusId = json['m_habitus_id'];
    bioCategory = json['bio_category'];
    dateFound = json['date_found'];
    totalFound = json['total_found'];
    distanceEstimation = json['distance_estimation'];
    observerActivity = json['observer_activity'];
    description = json['description'];
    area = json['area'];
    areaGroup = json['area_group'];
    gpsLng = json['gps_lng'];
    gpsLat = json['gps_lat'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updateAt = json['update_at'];
    updateBy = json['update_by'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.id;
    data['ina_name'] = this.inaName;
    data['eng_name'] = this.engName;
    data['latin_name'] = this.latinName;
    data['m_species_id'] = this.mSpeciesId;
    data['m_bio_class_id'] = this.mBioClassId;
    data['m_bio_family_id'] = this.mBioFamilyId;
    data['m_habitus_id'] = this.mHabitusId;
    data['bio_category'] = this.bioCategory;
    data['date_found'] = this.dateFound;
    data['total_found'] = this.totalFound;
    data['distance_estimation'] = this.distanceEstimation;
    data['observer_activity'] = this.observerActivity;
    data['description'] = this.description;
    data['area'] = this.area;
    data['area_group'] = this.areaGroup;
    data['gps_lng'] = this.gpsLng;
    data['gps_lat'] = this.gpsLat;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updateAt;
    data['updated_by'] = this.updateBy;
    return data;
  }
}