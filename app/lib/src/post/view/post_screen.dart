import 'package:app/src/post/data/clientinfo/test_http_client_info.dart';
import 'package:app/src/post/data/model/post.dart';
import 'package:app/src/post/data/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:http_client/http_client.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late HttpClientInfo _clientInfo = TestFSHttpClientInfo();
  late HttpClient _httpClient = HttpClient(_clientInfo);
  late PostRepository postRepository = PostRepository(_httpClient);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Network Layer'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // GET
            _getPostWidget(),
            SizedBox(
              height: 20,
            ),
            _getPostsWidget(),
            SizedBox(
              height: 20,
            ),

            // POST
            _createPostWidget(),
            SizedBox(
              height: 20,
            ),

            // PUT
            _updatePostWidget(),
            SizedBox(
              height: 20,
            ),

            // DELETE
            _deletePostWidget(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPostWidget() {
    return ElevatedButton(
      onPressed: () async {
        var post = await postRepository.getPost(1);

        print("-------------------Get Post-------------------");
        print(post);
        print("----------------------------------------------");
      },
      child: Text('Get Post'),
    );
  }

  Widget _getPostsWidget() {
    return ElevatedButton(
      onPressed: () async {
        var posts = await postRepository.getPosts();

        print("-------------------Get Posts-------------------");
        print(posts);
        print("----------------------------------------------");
      },
      child: Text('Get Posts'),
    );
  }

  Widget _createPostWidget() {
    return ElevatedButton(
      onPressed: () async {
        var post = await postRepository.createPost(Post(
          userId: 1,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
        ));

        print("-------------------Create Post-------------------");
        print(post);
        print("----------------------------------------------");
      },
      child: Text('Create Post'),
    );
  }

  Widget _updatePostWidget() {
    return ElevatedButton(
      onPressed: () async {
        var post = await postRepository.updatePost(Post(
          userId: 1,
          id: 1,
          title: 'Test Title Updated',
          body: 'Test Body Updated',
        ));

        print("-------------------Update Post-------------------");
        print(post);
        print("----------------------------------------------");
      },
      child: Text('Update Post'),
    );
  }

  Widget _deletePostWidget() {
    return ElevatedButton(
      onPressed: () async {
        await postRepository.deletePost(1);

        print("-------------------Delete Post-------------------");
        print('Post Deleted');
        print("----------------------------------------------");
      },
      child: Text('Delete Post'),
    );
  }
}
