import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/features/users/views/settings_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/users/views/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/clone_assignment/utils.dart';

// 에러 방지를 위한 임시 Thread 위젯
class Thread extends StatelessWidget {
  const Thread({super.key});
  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage("https://picsum.photos/200"),
      ),
      title: Text("Dummy Thread"),
      subtitle: Text("Thread details here"),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  static const String routeURL = '/profile';
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _onSettingTap() {
    context.goNamed(SettingsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.public),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: _onSettingTap,
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: NestedScrollView(
                // headerSliverBuilder에 프로필 헤더와 탭바를 정의합니다.
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    // 프로필 헤더 SliverAppBar
                    SliverAppBar(
                      expandedHeight: 176,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: FlexibleSpaceBar(
                          background: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Jane',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gaps.v4,
                                      Row(
                                        children: [
                                          const Text(
                                            'jane_mobbin',
                                            style: TextStyle(),
                                          ),
                                          Gaps.h4,
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              'threads.net',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://picsum.photos/200"),
                                    radius: 30,
                                  )
                                ],
                              ),
                              Gaps.v4,
                              const Text('Plant enthusiast!'),
                              Gaps.v12,
                              const Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://picsum.photos/200"),
                                    radius: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://picsum.photos/200"),
                                    radius: 10,
                                  ),
                                  Gaps.h8,
                                  Text(
                                    '2 followers',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v12,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        'Edit profile',
                                        style: TextStyle(
                                            color: isDarkMode(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  Gaps.h12,
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        'Share profile',
                                        style: TextStyle(
                                            color: isDarkMode(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // 탭바 고정 영역
                    SliverPersistentHeader(
                      delegate: PersistentTabBar(),
                      pinned: true,
                    ),
                  ];
                },
                // NestedScrollView의 body에 탭 컨텐츠를 배치합니다.
                body: TabBarView(
                  children: [
                    // 첫 번째 탭: ListView.builder
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage("https://picsum.photos/200"),
                          ),
                          title: Text('Jane'),
                          subtitle: Text('jane_mobbin'),
                          trailing: Icon(Icons.more_vert),
                        );
                      },
                    ),
                    // 두 번째 탭: ListView.separated (Thread 위젯 사용)
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => const Thread(),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                        indent: 72,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
