import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:home_dz/models/category.dart';
import 'package:home_dz/models/post.dart';
import 'package:home_dz/models/filter.dart';
import 'package:home_dz/models/section.dart';

import '../config.dart';

class HomeController extends GetxController {
  List<Post> lisPosts = [];
  List<Category> listCategories = [];
  List<Section> listSections = [];
  var loading_categories = true;
  var loading_posts = true;
  Filter postFilter = Filter();
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
        listCategories.insert(0, Category(name: "الكل", id: null));
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
      final response = await dioRequest.post(Config.baseServerUrl + '/posts',
          data: postFilter.toJson());
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
    super.onClose();
  }

  void selectCategorie(int indexCategory) {
    postFilter.categoryId = listCategories[indexCategory].id;
    postFilter.sectionId = null;
    listSections = listCategories[indexCategory].sections ?? [];
    update();
    getPosts();
  }

  void selectSection(int indexSection) {
    postFilter.sectionId = listSections[indexSection].id;
    update();
    getPosts();
  }
}
