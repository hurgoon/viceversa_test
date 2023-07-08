import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:viceversa_test/image_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataController extends GetxController {
  final dioo.Dio dio = dioo.Dio();

  int currentPage = 0;
  final RxList<ImageData> imageDataList = <ImageData>[].obs;
  final RxBool isLoading = false.obs;
  final ScrollController gridScrollCtrl = ScrollController();
  final String serviceKey = dotenv.env['SERVICE_KEY'] ?? '';

  Future getImageData(int page) async {
    try {
      const String url = 'https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1';
      Map<String, dynamic> queryParameters = {
        'serviceKey': serviceKey,
        'numOfRows': 30,
        'pageNo': page,
        'MobileOS': 'ETC',
        'MobileApp': 'AppTest',
        'arrange': 'A',
        '_type': 'json',
      };

      dioo.Response response = await dio.get(url, queryParameters: queryParameters);

      return response.data;
    } catch (e) {
      debugPrint('⚠️ error @  : $e');
    }
  }

  void appendImageData(Map<String, dynamic> rawData) {
    final List<Map<String, dynamic>> tempData =
        List<Map<String, dynamic>>.from(rawData['response']['body']['items']['item']);

    for (final Map<String, dynamic> data in tempData) {
      imageDataList.add(ImageData.fromJson(data));
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadImage();

    // infinite scroll
    gridScrollCtrl.addListener(() {
      if (gridScrollCtrl.position.pixels == gridScrollCtrl.position.maxScrollExtent) {
        loadImage();
      }
    });
  }

  Future<void> loadImage() async {
    if (isLoading.value) return; // 중복 로딩 방지

    isLoading.value = true;
    currentPage++;

    final Map<String, dynamic> nextData = (await getImageData(currentPage)) as Map<String, dynamic>;
    appendImageData(nextData);

    isLoading.value = false;
  }
}
