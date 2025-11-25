class District {
  int? id;
  String? name;
  String? zipCode;

  District({this.id, this.name, this.zipCode});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['zip_code'] = zipCode;
    return data;
  }
}
