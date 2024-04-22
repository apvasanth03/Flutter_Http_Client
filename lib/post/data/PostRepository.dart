import 'dart:convert';

import 'package:http/http.dart';
import 'package:network_layer/http/FSHttpClient.dart';
import 'package:network_layer/http/model/FSHttpMethod.dart';
import 'package:network_layer/post/data/model/Post.dart';

class PostRepository {
  final FSHttpClient httpClient;

  PostRepository(this.httpClient);

  // region GET
  Future<List<Post>> getPosts() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var request = Request(FSHttpMethod.GET.name, uri);

    var posts = await httpClient.send(
        request: request,
        parser: (json) {
          return (json as List).map((e) => Post.fromJson(e)).toList();
        });

    return posts;
  }

  Future<Post> getPost(int id) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    var request = Request(FSHttpMethod.GET.name, uri);

    var post = await httpClient.send(
        request: request,
        parser: (json) {
          return Post.fromJson(json);
        });

    return post;
  }

// endregion

  // region POST
  Future<Post> createPost(Post post) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var request = Request(FSHttpMethod.POST.name, uri);
    request.body = jsonEncode(post);

    var createdPost = await httpClient.send(
        request: request,
        parser: (json) {
          return Post.fromJson(json);
        });

    return createdPost;
  }

// endregion

  // region PUT
  Future<Post> updatePost(Post post) async {
    var uri =
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}');
    var request = Request(FSHttpMethod.PUT.name, uri);
    request.body = jsonEncode(post);

    var updatedPost = await httpClient.send(
        request: request,
        parser: (json) {
          return Post.fromJson(json);
        });

    return updatedPost;
  }

  // endregion

  // region DELETE
  Future<void> deletePost(int id) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    var request = Request(FSHttpMethod.DELETE.name, uri);

    await httpClient.send(
        request: request,
        parser: (json) {
          return null;
        });
  }
// endregion
}
