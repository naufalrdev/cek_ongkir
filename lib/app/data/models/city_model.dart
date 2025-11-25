class City {
  int? id;
  String? name;
  String? zipCode;

  City({this.id, this.name, this.zipCode});

  City.fromJson(Map<String, dynamic> json) {
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
