import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_dz/models/comment.dart';
import 'package:home_dz/models/post.dart';
import 'package:home_dz/models/filter.dart';
import 'package:home_dz/service/HelperService.dart';

import '../config.dart';

class DetailController extends GetxController {
  var loadingComments = true;
  List<Comment> listComments = [];
  List<Post> listPostsByUser = [];
  List<Post> listPostsBySection = [];
  bool addCommentLoading = false;
  String countComments = "";

  bool isFav = false;
  bool isLoadingFav = true;

  final helperService = Get.find<HelperService>();
  TextEditingController textCommentController = TextEditingController(text: "");
  @override
  void onInit() {
    super.onInit();
    postFilter.userId = helperService.post!.userId;
    postFilter.sectionId = helperService.post!.sectionId;

    checkFav(helperService.post!.id!);
    getPostsUser().then((value) {
      getPostsSection();
    });
    getComments();
  }

  Filter postFilter = Filter();
  Future getPostsUser() async {
    try {
      // loadingComments = false;
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.post(
        Config.baseServerUrl + '/posts',
        data: {"user_id": postFilter.userId},
      );
      if (response.statusCode == 200) {
        listPostsByUser = (response.data["data"] as List)
            .map((x) => Post.fromJson(x))
            .toList();

        // loadingComments = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  getPostsSection() async {
    try {
      // loadingComments = false;
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.post(
        Config.baseServerUrl + '/posts',
        data: {"section_id": postFilter.sectionId},
      );
      if (response.statusCode == 200) {
        listPostsBySection = (response.data["data"] as List)
            .map((x) => Post.fromJson(x))
            .toList();

        // loadingComments = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  getComments() async {
    try {
      loadingComments = false;
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

        loadingComments = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  addComment() async {
    try {
      addCommentLoading = true;
      update();
      var data = dio.FormData.fromMap({
        "post_id": helperService.post!.id.toString(),
        "user_id": 3,
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
        countComments = (int.parse(countComments) + 1).toString();
        addCommentLoading = false;
        update();
      }
    } catch (error, stacktrace) {
      addCommentLoading = false;
      update();
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  checkFav(int postId) async {
    isFav = await helperService.checkFavorite(postId);
    isLoadingFav = false;
    update();
  }

  addFav(int postId) async {
    isLoadingFav = true;
    update();
    isFav = await helperService.addFavorite(postId);
    isLoadingFav = false;

    update();
  }

  deleteFav(int postId) async {
    isLoadingFav = true;
    update();

    isFav = await helperService.removeFavorite(postId);
    isLoadingFav = false;

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<DetailController>();
  }
}
