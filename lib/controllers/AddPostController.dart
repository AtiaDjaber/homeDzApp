import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:home_dz/controllers/home_controller.dart';
import 'package:home_dz/models/category.dart';
import 'package:home_dz/models/post.dart';
import 'package:home_dz/models/section.dart';
import 'package:home_dz/views/home_view.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;

import '../config.dart';

class AddPostController extends GetxController {
  final homeCtr = Get.find<HomeController>();

  RxBool saving = false.obs;

  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController contactController = TextEditingController(text: "");
  RxBool isLoading = true.obs;
  List<Category> categories = [];
  List<Section> sections = [];

  int selectedCatgeory = -1;
  int selectedSection = -1;

  String userid = "";
  String username = "";

  File? fileToupload;
  String? fileName;
  List<File> files = [];
  String? base64ImageMain;
  List base64ListImage = [];
  Future getFile() async {
    files = [];
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      for (var element in result.files) {
        files.add(File(element.path!));
      }

      for (var element in files) {
        base64ImageMain = convert.base64Encode(element.readAsBytesSync());
        base64ImageMain = "data:image/jpeg;base64," + base64ImageMain!;
        base64ListImage.add(base64ImageMain);
      }
      update();
    } else {
      print('No image selected.');
    }
  }

  // addPosst() async {
  //   Get.dialog(
  //     Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: const [SpinKitDoubleBounce(color: Colors.blue, size: 50)],
  //     ),
  //     barrierDismissible: false,
  //   );

  //   Post post = Post(
  //     title: titleController.text,
  //     description: descriptionController.text,
  //     userId: 1,
  //     address: "",
  //   );

  //   var url = 'https://home_dz.com/rest/posts/addpost';

  //   http.Response response = await http.post(Uri.parse(url),
  //       headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //       body: post.toJson());
  //   ///////////////////
  //   ///////////////////
  //   var response2 = json.decode(response.body);
  //   url =
  //       'https://home_dz.com/rest/Postsimages/addimage?token=94b60eed96ffb3c00c03708a8c2ff65d35e0e4317fa3a25599452288bca16ea8';
  //   if (response2["msg"].toString().contains("نجاح")) {
  //     base64ListImage.forEach((element) async {
  //       body = {
  //         "post_id": response2["post_id"].toString(),
  //         "user_id": userid.toString(),
  //         "image": element
  //       };

  //       response = await http.post(Uri.parse(url),
  //           headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //           body: body);
  //       print(json.decode(response.body));
  //     });
  //     // getPostById(response2["post_id"].toString());
  //     base64ListImage = [];
  //     files = [];
  //     titleController.text = "";
  //     descriptionController.text = "";
  //     contactController.text = "";
  //   }
  // }

  addPost() async {
    try {
      Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [SpinKitDoubleBounce(color: Colors.blue, size: 50)],
        ),
        barrierDismissible: false,
      );
      Post post = Post(
        title: titleController.text,
        description: descriptionController.text,
        userId: 1,
        address: "asda",
        photo:
            "https://www.photoshopessentials.com/newsite/wp-content/uploads/2018/08/resize-images-print-photoshop-f.jpg",
        locationId: 1,
        categorieId: homeCtr.listCategories[selectedCatgeory].id,
        sectionId: sections[selectedSection].id,
      );

      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.post(
        Config.baseServerUrl + '/post/add',
        data: post.toJson(),
      );
      if (response.statusCode == 200) {
        homeCtr.lisPosts.add(Post.fromJson(response.data["data"]));
        update();
        Get.to(HomeView());
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // Future getPostById(String id) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };
  //   var url =
  //       'https://home_dz.com/rest/home/getpostbyid/$id?token=94b60eed96ffb3c00c03708a8c2ff65d35e0e4317fa3a25599452288bca16ea8';
  //   var response = await http.get(url, headers: headers);
  //   var jsonResponse = convert.jsonDecode(response.body);
  //   List list = jsonResponse as List;
  //   print(jsonResponse);
  //   for (var f in list) {
  //     String location_name = "";
  //     // var locationfromlist = f["0"]["locationData"] as List;

  //     // locationfromlist.forEach((f) {
  //     //   location_name = f["name"];
  //     // });
  //     // int len = 0;
  //     // var replyfromlist = f["1"]["replays"] as List;
  //     // len = replyfromlist.length;
  //     // print(f["id_user"]);
  //     Post p = new Post(
  //       f["id"],
  //       f["title"],
  //       f["user_id"],
  //       f["user_name"],
  //       f["location"],
  //       "0",
  //       f["time"],
  //       f["picture"],
  //       f["contain"],
  //       f["category_id"],
  //     );
  //     // if (f["category_id"] == "1") {
  //     final ctrHome = Get.put(HomeController());
  //     ctrHome.lisPosts.add(p);
  //     // }
  //   }
  //   update();
  // }

  deleteImage(int index) {
    files.removeAt(index);
    base64ListImage.removeAt(index);
    update();
  }

  String? dropDownValue;
  File? tmpFile;
  String errMessage = 'Error Uploading Image';

  bool loading_Categories = false;

  @override
  void onInit() {
    super.onInit();
  }

  void selectedLoaction(String value) {
    dropDownValue = value;
    update();
  }

  void selectCategorie(int indexCategory) {
    selectedSection = -1;
    selectedCatgeory = indexCategory;
    sections = homeCtr.listCategories[indexCategory].sections ?? [];
    update();
  }

  void selectSection(int indexSection) {
    selectedSection = indexSection;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    Get.delete<AddPostController>();
  }
}
