import 'dart:developer';
import 'package:get/get.dart';
import 'package:task/models/comments_response_model.dart';
import 'package:task/models/post_model.dart';
import 'package:task/services/post/post_service.dart';

class PostController extends GetxController {
  var isLoading = false.obs;
  var posts = <Post>[].obs;
  var comments = <Data>[].obs;
  final PostService _postService = PostService();
  var isCommentOpened = false.obs;
  var isFavorite = false.obs;


  Future<void> fetchPosts() async {
    isLoading.value = true;
    posts.clear();
    try {
      var response = await _postService.fetchPosts();
      posts.addAll(response);
    } catch (e, s) {
      log('Error: $e,$s');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchComments() async {
    isLoading.value = true;
    posts.clear();
    update();

    try {
      var response = await _postService.fetchComments();
      comments.addAll(response);
    } catch (e, s) {
      log('Error: $e,$s');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(Post post) async {
    try {
      final response = await _postService.toggleFavorite(post.id);
      if (response) {
        post.liked = !post.liked;
        post.liked ? post.likes++ : post.likes--;
        posts.refresh();
      }
    } catch (e, s) {
      log('Error: $e,$s');
    } finally {
      isLoading.value = false;
    }
  }

  //! If the user wants to see the comments
  void expandComment() {
    isCommentOpened.value = !isCommentOpened.value;
    log('${isCommentOpened.value}');
  }
}
