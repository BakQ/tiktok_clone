import 'package:flutter/material.dart';
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
        // SliverAppBar: 스크롤 가능한 AppBar로, 사용자가 스크롤할 때 다양한 동작을 설정할 수 있음
        SliverAppBar(
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
        const SliverToBoxAdapter(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              )
            ],
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
        ),
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          floating: true,
        ),
        // SliverGrid: 스크롤 가능한 그리드 레이아웃을 생성하는 위젯
        SliverGrid(
          // SliverChildBuilderDelegate를 사용하여 동적으로 리스트 아이템을 생성
          delegate: SliverChildBuilderDelegate(
            // 총 50개의 아이템을 생성
            childCount: 50,
            // 각 아이템을 생성하는 빌더 함수
            (context, index) => Container(
              // 각 아이템의 배경색을 파란색 계열로 지정 (0~8 사이의 색상 반복)
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center, // 텍스트를 중앙 정렬
                child: Text("Item $index"), // 아이템 번호 표시
              ),
            ),
          ),
          // gridDelegate: 그리드의 배치 규칙을 정의
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            // 각 아이템의 최대 가로 크기 (100픽셀을 초과하지 않도록 조절)
            maxCrossAxisExtent: 100,
            // 아이템 사이의 수직 간격 (main axis 방향)
            mainAxisSpacing: Sizes.size20,
            // 아이템 사이의 수평 간격 (cross axis 방향)
            crossAxisSpacing: Sizes.size20,
            // 아이템의 가로:세로 비율 (1:1 정사각형)
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}

// SliverPersistentHeaderDelegate를 상속하여 커스텀 고정 헤더를 만듦
class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo, // 배경색을 남색(Indigo)으로 설정
      child: const FractionallySizedBox(
        heightFactor: 1, // 부모 컨테이너 높이의 100%를 차지하도록 설정
        child: Center(
          child: Text(
            'Title!!!!!', // 헤더에 표시될 제목
            style: TextStyle(
              color: Colors.white, // 텍스트 색상을 흰색으로 설정
            ),
          ),
        ),
      ),
    );
  }

  // maxExtent: 헤더의 최대 높이 (스크롤 확장 시 최대 높이)
  @override
  double get maxExtent => 150;

  // minExtent: 헤더의 최소 높이 (스크롤 시 축소될 때 최소 높이)
  @override
  double get minExtent => 80;

  // shouldRebuild: 기존 delegate와 비교하여 다시 빌드할지 여부를 결정
  // 여기서는 `false`로 설정하여 항상 동일한 형태를 유지
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
