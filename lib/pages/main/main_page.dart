import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controller/post_controller.dart';
import 'package:task/utils/constants/app_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task/utils/constants/extensions.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PostController postController = Get.put(PostController());

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //! Refresh to MainPage (up to down screen with hand)
  void _onRefresh() async {
    postController.fetchPosts();
    postController.fetchComments();
    _refreshController.refreshCompleted();
  }

  //! methods to run on page start
  @override
  void initState() {
    postController.fetchPosts();
    postController.fetchComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      elevation: 1,
      leading: const Icon(CupertinoIcons.camera),
      title: SizedBox(
          width: 100, height: 40, child: Image.asset(ImagePaths.instagramLogo)),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.logout)),
        Image.asset(
          ImagePaths.igTv,
          width: 25,
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(
            ImagePaths.messenger,
            width: 25,
            height: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SmartRefresher(
      header: const MaterialClassicHeader(),
      onRefresh: _onRefresh,
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      child: Column(
        children: [
          20.ph,
          _storyCircleListview(),
          20.ph,
          Obx(() {
            if (postController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (postController.posts.isEmpty) {
              return const Center(child: Text('No posts available'));
            }
            return Expanded(
              child: StoryCardListview(postController: postController),
            );
          }),
        ],
      ),
    );
  }

  Widget _storyCircleListview() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(4),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 5),
            child: CircleAvatar(
              radius: 29,
              backgroundColor: Colors.red,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImagePaths.oval),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryCardListview extends StatelessWidget {
  const StoryCardListview({
    super.key,
    required this.postController,
  });

  final PostController postController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      itemCount: postController.posts.length,
      itemBuilder: (context, index) {
        var post = postController.posts[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset(
                    ImagePaths.oval,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(post.user.username),
                  subtitle: const Text('Baku , Azerbaijan'),
                  trailing: const Icon(Icons.menu),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      post.media.first.path,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await postController.toggleFavorite(post);
                              },
                              child: Icon(
                                post.liked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: post.liked ? Colors.red : Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => postController.expandComment(),
                              child: const Icon(Icons.comment_outlined),
                            ),
                            Image.asset(
                              ImagePaths.messenger,
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.bookmark_add_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(26, 10, 0, 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundImage: AssetImage(ImagePaths.city),
                      ),
                      5.pw,
                      const Text('Liked by  '),
                      const Text(
                        'Messi and ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${post.likes} others',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Obx(() {
                  if (postController.comments.isNotEmpty &&
                      postController.isCommentOpened.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Comments:',
                            style: TextStyle(color: Colors.red),
                          ),
                          4.ph,
                          Text(
                            postController.comments[index].text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
