import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/widgets/more_bottom_sheet.dart';

class HomePageScreen extends StatelessWidget {
  final ScrollController scrollController;
  const HomePageScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        username: 'pubity',
        profilePic: 'https://i.pravatar.cc/150?img=2',
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
        profilePic: 'https://i.pravatar.cc/150?img=3',
        timeAgo: '5m',
        text: 'Elon alone on Twitter right now...',
        imageUrls: [
          'https://picsum.photos/400/300?1',
          'https://picsum.photos/400/300?2'
        ],
        likes: 512,
        replies: 78,
      ),
      Post(
        username: 'park',
        profilePic: 'https://i.pravatar.cc/150?img=6',
        timeAgo: '5m',
        text: 'Elon alone on Twitter right now...',
        imageUrls: [
          'https://picsum.photos/300/500?1',
          'https://picsum.photos/300/500?2',
          'https://picsum.photos/300/500?3',
          'https://picsum.photos/300/600?4'
        ],
        likes: 512,
        replies: 78,
      ),
    ];

    return Scrollbar(
      controller: scrollController,
      child: Scaffold(
        body: ListView.builder(
          controller: scrollController,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostContainer(post: posts[index]);
          },
        ),
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

  void _onTapEllipsis(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true, // Flutter 3.9 이상에서는 자동 핸들이 추가됩니다.
      context: context,
      builder: (context) => const OptionsBottomSheet(),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // 다크/라이트 모드에 따라 플러스 아이콘 컨테이너의 색상을 결정합니다.
    final plusBackgroundColor = isDark ? Colors.white : Colors.black;
    final plusIconColor = isDark ? Colors.black : Colors.white;
    final plusBorderColor = isDark ? Colors.black : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(post.profilePic),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 프로필 이미지 하단에 겹치는 플러스 아이콘
                  Positioned(
                    top: 22,
                    left: 22,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: plusBorderColor,
                          width: 2.5,
                        ),
                        color: plusBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: plusIconColor,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v8,
              // 테마의 dividerColor를 사용하여 세로 구분선 색상 설정
              Container(
                width: 2,
                height: 200,
                color: Theme.of(context).dividerColor,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(post.profilePic),
              ),
            ],
          ),
          Gaps.h8,
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
                    // 테마에 맞춰 시간 텍스트 색상을 설정
                    Text(
                      post.timeAgo,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    Gaps.h20,
                    GestureDetector(
                      onTap: () => _onTapEllipsis(context),
                      child: const FaIcon(FontAwesomeIcons.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(post.text),
                const SizedBox(height: 8),
                if (post.imageUrls.isNotEmpty)
                  Column(
                    children: [
                      Gaps.v10,
                      SizedBox(
                        height: Sizes.size96 + Sizes.size96 + Sizes.size20,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: post.imageUrls.length,
                          itemBuilder: (context, imgIndex) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: Sizes.size10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size8),
                                child: Image.network(post.imageUrls[imgIndex]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
