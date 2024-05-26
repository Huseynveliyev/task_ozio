import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:task/controller/auth_controller.dart';
import 'package:task/models/comments_response_model.dart';
import 'package:task/models/post_model.dart';

import 'package:task/utils/constants/api_config.dart';
import '../../logging/dio_interceptor.dart';

class PostService {
  AuthController authController = Get.find();
  final Dio _myDio = Dio();
  List<int> postId = [];
  PostService() {
    _myDio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _myDio.options.headers['Authorization'] = [
      'Bearer ${authController.box.read('token')}'
    ];
    _myDio.interceptors.add(
      DioInterceptor(),
    );
  }

  //! fetch User Posts
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _myDio.get('posts');
      if (response.statusCode == 200) {
        List<Post> posts = (response.data['data'] as List)
            .map((post) => Post.fromJson(post))
            .toList();

        postId.addAll(posts.map((post) => post.id).toList());
        return posts;
      } else {
        throw Exception();
      }
    } on DioException catch (e) {
      throw Exception('Failed to load posts: ${e.message}');
    }
  }

  //! fetch Post's comments
  Future<List<Data>> fetchComments() async {
    try {
      final response = await _myDio.get('posts/comments/1');
      if (response.statusCode == 200) {
        List<Data> comment = (response.data['data'] as List)
            .map((comment) => Data.fromJson(comment))
            .toList();
        return comment;
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load posts: ${e.message}');
    }
  }

  Future<bool> toggleFavorite(int postId) async {
    try {
      final response = await _myDio.get('posts/like/$postId');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw Exception('Something went worng: ${e.message}');
    }
  }
}
