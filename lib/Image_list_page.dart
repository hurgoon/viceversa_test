import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viceversa_test/data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:viceversa_test/image_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageListPage extends StatelessWidget {
  ImageListPage({super.key});

  final DataController dataCtrl = Get.put(DataController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Viceversa Test',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            dataCtrl.isLoading.value
                ? const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: CupertinoActivityIndicator(),
                  )
                : const SizedBox()
          ],
        ),
        body: (dataCtrl.imageDataList.isEmpty)
            ? const Center(child: CupertinoActivityIndicator())
            : GridView.count(
                controller: dataCtrl.gridScrollCtrl,
                crossAxisCount: 3,
                children: List.generate(dataCtrl.imageDataList.length, (index) {
                  final ImageData imageData = dataCtrl.imageDataList[index];

                  return InkWell(
                    onTap: () {
                      /// 상세 이미지 다이얼로그
                      showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                          onTap: () => Get.back(),
                          child: Dialog(
                            insetPadding: const EdgeInsets.all(8),
                            backgroundColor: Colors.black.withOpacity(0.9),
                            child: Stack(
                              children: [
                                Container(
                                  width: Get.width,
                                  height: Get.height,
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(imageData.galTitle,
                                          style: const TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                                      const SizedBox(height: 8),
                                      Flexible(
                                          child: InteractiveViewer(
                                              minScale: 0.1,
                                              maxScale: 5.0,
                                              child: Container(
                                                  constraints: BoxConstraints(minHeight: Get.height * 0.5),
                                                  child: CachedNetworkImage(imageUrl: imageData.galWebImageUrl)))),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.location_on, color: Colors.white),
                                          const SizedBox(width: 4),
                                          Text(imageData.galPhotographyLocation,
                                              style: const TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    onPressed: () => Get.back(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.black,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: CachedNetworkImage(
                            imageUrl: imageData.galWebImageUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const CupertinoActivityIndicator(color: Colors.white),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          )),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              imageData.galTitle,
                              style: const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      ),
    );
  }
}
