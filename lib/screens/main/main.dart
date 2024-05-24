import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/utils/constants/app_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  _buildBody() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _storyListview(),
        const SizedBox(
          height: 40,
        ),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(
                  ImagePaths.oval,
                  width: 50,
                  height: 50,
                ),
                title: const Text('jsoua'),
                subtitle: const Text('Tokyo, Japan'),
                trailing: const Icon(Icons.menu),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                child: Image.asset(
                  ImagePaths.city,
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.favorite_outline),
                          const Icon(
                            Icons.comment_outlined,
                          ),
                           Image.asset(ImagePaths.messenger, width: 20, height: 20,)   
                        ],
                      ),
                    ),
                    const Row(children: [
                      Icon(Icons.bookmark_add_outlined),
                    ]),
                  ],
                ),
              ), 
            
              Row(children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(ImagePaths.city,),)
              ],)
            ],
          ),
        )
      ],
    );
  }

  SizedBox _storyListview() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: 14,
        padding: const EdgeInsets.all(4),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ImagePaths.oval),
                    fit: BoxFit.cover,
                  )),
            ),
          );
        },
      ),
    );
  }
}
