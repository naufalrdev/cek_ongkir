// import 'package:get/get.dart';

// import '../models/sub_district_model.dart';

// class SubDistrictProvider extends GetConnect {
//   @override
//   void onInit() {
//     httpClient.defaultDecoder = (map) {
//       if (map is Map<String, dynamic>) return SubDistrict.fromJson(map);
//       if (map is List)
//         return map.map((item) => SubDistrict.fromJson(item)).toList();
//     };
//     httpClient.baseUrl = 'YOUR-API-URL';
//   }

//   Future<SubDistrict?> getSubDistrict(int id) async {
//     final response = await get('subdistrict/$id');
//     return response.body;
//   }

//   Future<Response<SubDistrict>> postSubDistrict(
//           SubDistrict subdistrict) async =>
//       await post('subdistrict', subdistrict);
//   Future<Response> deleteSubDistrict(int id) async =>
//       await delete('subdistrict/$id');
// }
