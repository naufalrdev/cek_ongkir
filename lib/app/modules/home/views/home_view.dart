import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/city_model.dart';
import '../../../data/models/district_model.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/sub_district_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ongkos Kirim'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            asyncItems: (String? filter) async {
              final dio = Dio();

              final response = await dio.get(
                "https://rajaongkir.komerce.id/api/v1/destination/province",
                options: Options(
                  headers: {
                    "key": "3Avzz1W1ee866909e4d6cb0640J2Rnon",
                    "Accept": "application/json",
                  },
                ),
              );

              final List data = response.data["data"];
              return data.map((e) => Province.fromJson(e)).toList();
            },

            itemAsString: (Province p) => p.name ?? "",
            compareFn: (item1, item2) => item1.id == item2.id,
            onChanged: (value) {
              FocusScope.of(context).unfocus();
              controller.provAsalId.value = value?.id.toString() ?? "0";
            },
            popupProps: PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Provinsi",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          DropdownSearch<City>(
            asyncItems: (String? filter) async {
              final provId = controller.provAsalId.value;

              if (provId == "0") return [];

              final diogo = Dio();

              final response = await diogo.get(
                "https://rajaongkir.komerce.id/api/v1/destination/city/$provId",
                queryParameters: {"province": controller.provAsalId.value},
                options: Options(
                  headers: {
                    "key": "3Avzz1W1ee866909e4d6cb0640J2Rnon",
                    "Accept": "application/json",
                  },
                ),
              );

              final List data = response.data["data"];
              return data.map((e) => City.fromJson(e)).toList();
            },

            itemAsString: (City c) => c.name ?? "",
            compareFn: (item1, item2) => item1 == item2,
            onChanged: (value) {
              FocusScope.of(context).unfocus();
              controller.cityAsalId.value = value?.id.toString() ?? "0";
            },
            popupProps: PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kota",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          DropdownSearch<District>(
            asyncItems: (String? filter) async {
              final dio = Dio();

              final response = await dio.get(
                "https://rajaongkir.komerce.id/api/v1/destination/district/${controller.cityAsalId}",
                options: Options(
                  headers: {
                    "key": "3Avzz1W1ee866909e4d6cb0640J2Rnon",
                    "Accept": "application/json",
                  },
                ),
              );

              final List data = response.data["data"];
              return data.map((e) => District.fromJson(e)).toList();
            },

            itemAsString: (District d) => d.name ?? "",
            compareFn: (item1, item2) => item1.id == item2.id,
            onChanged: (value) {
              FocusScope.of(context).unfocus();
              controller.districtAsalId.value = value?.id.toString() ?? "0";
            },
            popupProps: PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kecamatan",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          DropdownSearch<SubDistrict>(
            asyncItems: (String? filter) async {
              final dio = Dio();

              final response = await dio.get(
                "https://rajaongkir.komerce.id/api/v1/destination/sub-district/${controller.districtAsalId}",
                options: Options(
                  headers: {
                    "key": "3Avzz1W1ee866909e4d6cb0640J2Rnon",
                    "Accept": "application/json",
                  },
                ),
              );

              final List data = response.data["data"];
              return data.map((e) => SubDistrict.fromJson(e)).toList();
            },

            itemAsString: (SubDistrict s) => s.name ?? "",
            compareFn: (item1, item2) => item1.id == item2.id,
            onChanged: (value) {
              FocusScope.of(context).unfocus();
              controller.subDistrictAsalId.value = value?.id.toString() ?? "0";
            },
            popupProps: PopupProps.menu(showSearchBox: true),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Kelurahan",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
