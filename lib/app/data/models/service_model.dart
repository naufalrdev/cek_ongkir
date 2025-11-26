class Service {
  Meta? meta;
  List<Data>? data;

  Service({this.meta, this.data});

  Service.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Meta {
  String? message;
  int? code;
  String? status;

  Meta({this.message, this.code, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? name;
  String? code;
  String? service;
  String? description;
  int? cost;
  String? etd;

  Data({
    this.name,
    this.code,
    this.service,
    this.description,
    this.cost,
    this.etd,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    service = json['service'];
    description = json['description'];
    cost = json['cost'];
    etd = json['etd'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['service'] = service;
    data['description'] = description;
    data['cost'] = cost;
    data['etd'] = etd;
    return data;
  }
}
