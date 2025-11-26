import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/service_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();

  RxString provAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString cityTujuanId = "0".obs;
  RxString districtAsalId = "0".obs;
  RxString districtTujuanId = "0".obs;

  RxList<Data> listService = <Data>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Future<void> cekOngkir() async {
    if (provAsalId.value == "0" ||
        provTujuanId.value == "0" ||
        cityAsalId.value == "0" ||
        cityTujuanId.value == "0" ||
        districtAsalId.value == "0" ||
        districtTujuanId.value == "0" ||
        beratC.text.isEmpty) {
      Get.defaultDialog(
        title: "TERJADI KESALAHAN",
        middleText: "Data Input Belum Lengkap",
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = "";

      final response = await http.post(
        Uri.parse(
          "https://rajaongkir.komerce.id/api/v1/calculate/district/domestic-cost",
        ),
        headers: {
          "key": "3Avzz1W1ee866909e4d6cb0640J2Rnon",
          "content-type": "application/x-www-form-urlencoded",
        },
        body: {
          "origin": districtAsalId.value,
          "destination": districtTujuanId.value,
          "weight": beratC.text,
          "courier":
              "jne:sicepat:ide:sap:jnt:ninja:tiki:lion:anteraja:pos:ncs:rex:rpx:sentral:star:wahana:dse",
        },
      );

      final decoded = json.decode(response.body);
      final service = Service.fromJson(decoded);

      if (service.meta?.code != 200) {
        throw service.meta?.message ?? "Gagal Mengambil Ongkir";
      }

      listService.value = service.data ?? [];
      Get.bottomSheet(
        buildOngkirSheet(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );

      listService.sort((a, b) => (a.cost ?? 0).compareTo(b.cost ?? 0));
    } catch (e) {
      errorMessage.value = e.toString();
      Get.defaultDialog(title: "ERROR", middleText: errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Widget buildOngkirSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 5,
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                "Pilih Layanan Pengiriman",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: scrollController,
                    itemCount: listService.length,
                    itemBuilder: (context, index) {
                      final item = listService[index];

                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.local_shipping),
                          title: Text("${item.name} - ${item.service}"),
                          subtitle: Text(item.description ?? ""),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rp ${item.cost}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(item.etd ?? ""),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
