import 'package:flutter/material.dart';

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
        // SliverAppBar: 스크롤 가능한 AppBar로, 사용자가 스크롤할 때 다양한 동작을 설정할 수 있음
        SliverAppBar(
          // snap: true - 사용자가 스크롤을 멈추면 AppBar가 자동으로 접히거나 펼쳐짐
          snap: true,
          // floating: true - AppBar가 리스트를 스크롤할 때 위로 사라지지만, 다시 스크롤하면 즉시 나타남
          floating: true,
          // pinned: true - AppBar가 완전히 사라지지 않고, 최소 높이만큼 화면에 남아 있도록 고정됨
          pinned: true,
          // stretch: true - 리스트를 끝까지 당겼을 때 AppBar가 확장되며 배경 효과를 줌
          stretch: true,
          // AppBar의 배경색 지정
          backgroundColor: Colors.teal,
          // 스크롤 시 최소한으로 남아있는 높이 설정
          collapsedHeight: 80,
          // 최대 확장 높이 설정
          expandedHeight: 200,
          // FlexibleSpaceBar를 사용하여 AppBar의 배경과 제목에 다양한 효과 추가
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              // 배경 흐리게 처리 (iOS의 블러 효과)
              StretchMode.blurBackground,
              // 배경을 확대하여 부드러운 스크롤 효과 제공
              StretchMode.zoomBackground,
              // 제목이 스크롤 시 자연스럽게 사라지도록 설정
              StretchMode.fadeTitle,
            ],
            background: Image.asset(
              "assets/images/placeholder.png",
              fit: BoxFit.cover,
            ),
            title: const Text("Hello!"),
          ),
        ),
        // 리스트 아이템을 SliverFixedExtentList를 사용하여 배치
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100, // 각 아이템의 높이를 100으로 고정
        )
      ],
    );
  }
}
