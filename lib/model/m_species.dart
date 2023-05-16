
class MSpecies {
  String? id;
  String? inaName;
  String? engName;
  String? latinName;
  String? mBioClassId;
  String? mBioClassName;
  String? mBioFamilyId;
  String? mBioFamilyName;
  String? mHabitusId;
  String? mHabitusName;
  String? ncbiCode;
  String? code;
  String? bioCategory;
  String? imageUrl;
  String? mCompanyCode;
  String? description;
  String? govRulePp;
  String? govRulePermenlhk106;
  String? iucn;

  MSpecies(
      {this.id,
        this.inaName,
        this.engName,
        this.latinName,
        this.mBioClassId,
        this.mBioClassName,
        this.mBioFamilyId,
        this.mBioFamilyName,
        this.mHabitusId,
        this.mHabitusName,
        this.ncbiCode,
        this.code,
        this.bioCategory,
        this.imageUrl,
        this.mCompanyCode,
        this.description,
        this.govRulePp,
        this.govRulePermenlhk106,
        this.iucn});

  MSpecies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inaName = json['ina_name'];
    engName = json['eng_name'];
    latinName = json['latin_name'];
    mBioClassId = json['m_bio_class_id'];
    mBioClassName = json['m_bio_class_name'];
    mBioFamilyId = json['m_bio_family_id'];
    mBioFamilyName = json['m_bio_family_name'];
    mHabitusId = json['m_habitus_id'];
    mHabitusName = json['m_habitus_name'];
    ncbiCode = json['ncbi_code'];
    code = json['code'];
    bioCategory = json['bio_category'];
    imageUrl = json['image_url'];
    mCompanyCode = json['m_company_code'];
    description = json['description'];
    govRulePp = json['gov_rule_pp'];
    govRulePermenlhk106 = json['gov_rule_permenlhk106'];
    iucn = json['iucn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ina_name'] = this.inaName;
    data['eng_name'] = this.engName;
    data['latin_name'] = this.latinName;
    data['m_bio_class_id'] = this.mBioClassId;
    data['m_bio_class_name'] = this.mBioClassName;
    data['m_bio_family_id'] = this.mBioFamilyId;
    data['m_bio_family_name'] = this.mBioFamilyName;
    data['m_habitus_id'] = this.mHabitusId;
    data['m_habitus_name'] = this.mHabitusName;
    data['ncbi_code'] = this.ncbiCode;
    data['code'] = this.code;
    data['bio_category'] = this.bioCategory;
    data['image_url'] = this.imageUrl;
    data['m_company_code'] = this.mCompanyCode;
    data['description'] = this.description;
    data['gov_rule_pp'] = this.govRulePp;
    data['gov_rule_permenlhk106'] = this.govRulePermenlhk106;
    data['iucn'] = this.iucn;
    return data;
  }
}