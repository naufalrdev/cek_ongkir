import 'package:get/get.dart';

import '../models/district_model.dart';

class DistrictProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return District.fromJson(map);
      if (map is List)
        return map.map((item) => District.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<District?> getDistrict(int id) async {
    final response = await get('district/$id');
    return response.body;
  }

  Future<Response<District>> postDistrict(District district) async =>
      await post('district', district);
  Future<Response> deleteDistrict(int id) async => await delete('district/$id');
}
