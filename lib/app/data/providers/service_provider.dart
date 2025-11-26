import 'package:get/get.dart';

import '../models/service_model.dart';

class ServiceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Service.fromJson(map);
      if (map is List)
        return map.map((item) => Service.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Service?> getService(int id) async {
    final response = await get('service/$id');
    return response.body;
  }

  Future<Response<Service>> postService(Service service) async =>
      await post('service', service);
  Future<Response> deleteService(int id) async => await delete('service/$id');
}
