import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar: 스크롤 가능한 AppBar
        SliverAppBar(
          title: const Text('니꼬'), // AppBar의 제목
          actions: [
            IconButton(
              onPressed: () {}, // 설정 버튼 클릭 시 실행할 함수 (현재 비어 있음)
              icon: const FaIcon(
                FontAwesomeIcons.gear, // FontAwesome 아이콘 (톱니바퀴)
                size: Sizes.size20,
              ),
            ),
          ],
        ),

        // SliverToBoxAdapter: 일반 위젯을 Sliver 형태로 추가할 때 사용
        SliverToBoxAdapter(
          child: Column(
            children: [
              // 프로필 이미지 (원형 아바타)
              const CircleAvatar(
                radius: 50, // 아바타 크기 설정
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/3612017",
                ), // 네트워크에서 프로필 이미지 불러오기
                child: Text("니꼬"), // 이미지가 로드되지 않을 경우 표시할 텍스트
              ),
              Gaps.v20, // 위젯 사이의 간격 (20px)

              // 사용자 이름 및 인증 아이콘
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                children: [
                  const Text(
                    "@니꼬", // 사용자 핸들
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size18,
                    ),
                  ),
                  Gaps.h5, // 텍스트와 아이콘 사이의 간격
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck, // 인증 체크 아이콘
                    size: Sizes.size16,
                    color: Colors.blue.shade500, // 파란색 체크 아이콘
                  ),
                ],
              ),
              Gaps.v24, // 위젯 간 간격 (24px)

              // Following, Followers, Likes 정보 섹션
              SizedBox(
                //높이가 있어야 세로 구분선이나온다.
                height: Sizes.size52, // 섹션 높이 지정
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  children: [
                    // Following (팔로잉 정보)
                    Column(
                      children: [
                        const Text(
                          "97", // 팔로잉 수
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3, // 텍스트 간격
                        Text(
                          "Following",
                          style: TextStyle(
                            color: Colors.grey.shade500, // 흐린 회색 텍스트
                          ),
                        ),
                      ],
                    ),

                    // 세로 구분선
                    VerticalDivider(
                      width: Sizes.size32, // 구분선과 텍스트 사이 여백
                      thickness: Sizes.size1, // 구분선 두께
                      color: Colors.grey.shade400, // 회색 구분선
                      indent: Sizes.size14, // 위쪽 여백
                      endIndent: Sizes.size14, // 아래쪽 여백
                    ),

                    // Followers (팔로워 수)
                    Column(
                      children: [
                        const Text(
                          "10M", // 팔로워 수 (1000만 명)
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                          "Followers",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    // 또 다른 세로 구분선
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade400,
                      indent: Sizes.size14,
                      endIndent: Sizes.size14,
                    ),

                    // Likes (좋아요 수)
                    Column(
                      children: [
                        const Text(
                          "194.3M", // 좋아요 수 (1억 9430만)
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                          "Likes",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
