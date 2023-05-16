
class Fauna {
  String? name;
  String? imageUrl;
  String? company;
  String? clarifier;
  String? family;
  String? scienceName;
  String? generalName;
  String? regulation;
  String? iucn;

  Fauna(
      {this.name,
        this.imageUrl,
        this.company,
        this.clarifier,
        this.family,
        this.scienceName,
        this.generalName,
        this.regulation,
        this.iucn});

  Fauna.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['image_url'];
    company = json['company'];
    clarifier = json['clarifier'];
    family = json['family'];
    scienceName = json['science_name'];
    generalName = json['general_name'];
    regulation = json['regulation'];
    iucn = json['iucn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['company'] = company;
    data['clarifier'] = clarifier;
    data['family'] = family;
    data['science_name'] = scienceName;
    data['general_name'] = generalName;
    data['regulation'] = regulation;
    data['iucn'] = iucn;
    return data;
  }
}