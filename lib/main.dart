import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_dz/service/HelperService.dart';
import 'package:home_dz/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(HelperService());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetMaterialApp(
        title: 'Home Dz',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Tajawal"),
        home: HomeView(),
      ),
    );
  }
}
