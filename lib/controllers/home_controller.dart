import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:home_dz/models/category.dart';
import 'package:home_dz/models/post.dart';
import 'package:home_dz/models/section.dart';

import '../config.dart';

class HomeController extends GetxController {
  List<Post> lisPosts = [];
  List<Category> listCategories = [];
  List<Section> listSections = [];
  var loading_categories = true;
  var loading_posts = true;

  bool secend_loading_post = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPosts();
    getCategories();
  }

  getCategories() async {
    try {
      loading_categories = false;
      var dioRequest = Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response =
          await dioRequest.get(Config.baseServerUrl + '/categories');
      if (response.statusCode == 200) {
        listCategories =
            (response.data as List).map((x) => Category.fromJson(x)).toList();
        loading_categories = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  getPosts() async {
    try {
      loading_posts = false;
      var dioRequest = Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.get(Config.baseServerUrl + '/posts');
      if (response.statusCode == 200) {
        lisPosts = (response.data["data"] as List)
            .map((x) => Post.fromJson(x))
            .toList();
        loading_posts = true;
        update();
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void selectCategorie(int index) {
    listSections = listCategories[index].sections ?? [];
    update();
  }
}
