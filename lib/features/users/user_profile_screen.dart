import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // 장치의 상태 표시줄과 겹치지 않도록 함
      child: DefaultTabController(
        length: 2, // TabBar의 탭 개수 (2개)
        child: NestedScrollView(
          // Sliver 목록을 생성하는 빌더
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // SliverAppBar: 스크롤 가능한 AppBar
              SliverAppBar(
                title: const Text('니꼬'), // 앱바 제목
                actions: [
                  IconButton(
                    onPressed: _onGearPressed, // 설정 버튼 클릭 시 실행할 함수 (현재 비어 있음)
                    icon: const FaIcon(
                      FontAwesomeIcons.gear, // FontAwesome 아이콘 (톱니바퀴)
                      size: Sizes.size20,
                    ),
                  )
                ],
              ),

              // SliverToBoxAdapter: 일반 위젯을 Sliver로 감싸서 추가
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // 프로필 이미지 (원형 아바타)
                    const CircleAvatar(
                      radius: 50, // 아바타 크기 설정
                      foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/3612017"),
                      child: Text("니꼬"),
                    ),
                    Gaps.v20,

                    // 사용자 이름 및 인증 아이콘
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@니꼬",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck, // 인증 체크 아이콘
                          size: Sizes.size16,
                          color: Colors.blue.shade500, // 파란색 체크 아이콘
                        ),
                      ],
                    ),
                    Gaps.v24,

                    // Following, Followers, Likes 정보 섹션
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Following 정보
                          Column(
                            children: [
                              const Text(
                                "97", // 팔로잉 수
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.size18,
                                ),
                              ),
                              Gaps.v1,
                              Text("Following",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ))
                            ],
                          ),
                          VerticalDivider(
                            // 세로 구분선
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),

                          // Followers 정보
                          Column(
                            children: [
                              const Text(
                                "10M", // 팔로워 수
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.size18,
                                ),
                              ),
                              Gaps.v1,
                              Text(
                                "Followers",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              )
                            ],
                          ),
                          VerticalDivider(
                            // 또 다른 세로 구분선
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),

                          // Likes 정보
                          Column(
                            children: [
                              const Text(
                                "194.3M", // 좋아요 수
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.size18,
                                ),
                              ),
                              Gaps.v1,
                              Text(
                                "Likes",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Gaps.v14,

                    // 팔로우 버튼
                    FractionallySizedBox(
                      widthFactor: 0.33, // 부모의 33% 너비 차지
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor, // 테마 색상 적용
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.size4),
                          ),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gaps.v14,

                    // 소개글
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+ I wonder how it would look",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,

                    // 링크
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://nomadcoders.co",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),

              // SliverPersistentHeader: TabBar를 고정하여 표시
              SliverPersistentHeader(
                delegate: PersistentTabBar(), // 커스텀 탭바
                pinned: true, // 스크롤 시 상단에 고정됨
              ),
            ];
          },

          // TabBarView: 탭의 내용을 표시하는 부분
          body: TabBarView(
            children: [
              // 첫 번째 탭: 그리드 형태의 게시물 목록
              GridView.builder(
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3개의 열
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 14, // 아이템의 비율 조정
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 14,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/images/placeholder.jpg",
                        image:
                            "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                      ),
                    ),
                  ],
                ),
              ),

              // 두 번째 탭 (예제)
              const Center(
                child: Text('Page two'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
