import 'package:get/get.dart';
import 'package:home_dz/models/post.dart';

import '../config.dart';
import 'package:dio/dio.dart' as dio;

class HelperService extends GetxService {
  String? token;
  String? firebaseToken;
  // User? user;
  Post? post;

  Future<bool> addFavorite(int postId) async {
    try {
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.post(
        Config.baseServerUrl + '/favorite/add',
        data: {"post_id": postId},
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> removeFavorite(int postId) async {
    try {
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.delete(
        Config.baseServerUrl + '/favorite/remove',
        data: {"post_id": postId},
      );
      if (response.statusCode == 200) {
        return false;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> checkFavorite(int postId) async {
    try {
      var dioRequest = dio.Dio();
      dioRequest.options.headers['content-Type'] = 'application/json';
      // dioRequest.options.headers["authorization"] = helperService.token;
      final response = await dioRequest.get(
        Config.baseServerUrl + '/favorite/check/' + postId.toString(),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
