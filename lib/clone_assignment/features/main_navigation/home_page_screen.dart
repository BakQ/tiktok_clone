import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        username: 'pubity',
        profilePic: 'https://via.placeholder.com/50',
        timeAgo: '2m',
        text: 'Vine after seeing the Threads logo unveiled',
        imageUrls: [
          'https://picsum.photos/400/300',
          'https://picsum.photos/400/300'
        ],
        likes: 391,
        replies: 36,
      ),
      Post(
        username: 'thetinderblog',
        profilePic: 'https://via.placeholder.com/50',
        timeAgo: '5m',
        text: 'Elon alone on Twitter right now...',
        imageUrls: [
          'https://picsum.photos/300/500',
          'https://picsum.photos/300/600'
        ],
        likes: 512,
        replies: 78,
      ),
      Post(
        username: 'park',
        profilePic: 'https://via.placeholder.com/50',
        timeAgo: '5m',
        text: 'Elon alone on Twitter right now...',
        imageUrls: [
          'https://picsum.photos/300/500',
          'https://picsum.photos/300/600'
        ],
        likes: 512,
        replies: 78,
      ),
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostContainer(post: posts[index]);
        },
      ),
    );
  }
}

class Post {
  final String username;
  final String profilePic;
  final String timeAgo;
  final String text;
  final List<String> imageUrls;
  final int likes;
  final int replies;

  Post({
    required this.username,
    required this.profilePic,
    required this.timeAgo,
    required this.text,
    required this.imageUrls,
    required this.likes,
    required this.replies,
  });
}

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(post.profilePic),
              ),
              const SizedBox(height: 8),
              // 세로선이 이미지 크기에 맞게 조절되도록 ClipRRect 내부에서 Positioned 사용
              Container(
                width: 2,
                height: 200, // 기본값, 아래에서 자동 조절됨
                color: Colors.grey.shade300,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(post.profilePic),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, color: Colors.blue, size: 16),
                    const Spacer(),
                    Text(
                      post.timeAgo,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Gaps.h20,
                    const FaIcon(FontAwesomeIcons.ellipsis),
                  ],
                ),
                const SizedBox(height: 4),
                Text(post.text),
                const SizedBox(height: 8),
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    itemCount: post.imageUrls.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(post.imageUrls[index]),
                      );
                    },
                  ),
                ),
                Gaps.v12,
                const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.heart),
                    Gaps.h16,
                    FaIcon(FontAwesomeIcons.message),
                    Gaps.h16,
                    FaIcon(FontAwesomeIcons.rotate),
                    Gaps.h16,
                    FaIcon(FontAwesomeIcons.paperPlane),
                  ],
                ),
                Gaps.v12,
                Row(
                  children: [
                    Text('${post.replies} replies'),
                    Gaps.h8,
                    const Text('.'),
                    Gaps.h8,
                    Text('${post.likes} likes'),
                    const Spacer(),
                    const Icon(Icons.share),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
