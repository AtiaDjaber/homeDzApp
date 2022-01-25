import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_dz/models/comment.dart';
import 'package:home_dz/service/HelperService.dart';

import '../config.dart';

class DetailController extends GetxController {
  var loading_comments = true;
  List<Comment> listComments = [];
  bool secend_loading_post = false;
  bool addCommentLoading = false;
  final helperService = Get.find<HelperService>();
  TextEditingController textCommentController = TextEditingController(text: "");
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getComments();
  }

  getComments() async {
    try {
      loading_comments = false;
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.get(Config.baseServerUrl +
          '/comments?post_id=' +
          helperService.post!.id.toString());
      if (response.statusCode == 200) {
        listComments = (response.data["data"] as List)
            .map((x) => Comment.fromJson(x))
            .toList();
        countComments = response.data["total"].toString();

        loading_comments = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  String countComments = "";
  addComment() async {
    try {
      addCommentLoading = true;
      update();
      var data = dio.FormData.fromMap({
        "post_id": helperService.post!.id.toString(),
        "user_id": helperService.post!.id.toString(),
        "text": textCommentController.text,
      });
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest
          .post(Config.baseServerUrl + '/comment/add', data: data);
      if (response.statusCode == 200) {
        textCommentController.text = "";
        listComments.insert(0, Comment.fromJson(response.data));

        addCommentLoading = false;
        update();
      }
    } catch (error, stacktrace) {
      addCommentLoading = false;
      update();
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<DetailController>();
  }
}
