import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/home_page_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/write_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/users/user_profile_screen.dart';

import 'widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final ScrollController _scrollController = ScrollController();

  int _selectedIndex = 4;
  bool _showTitle = false;

  final screens = [
    const Center(
      child: Text(
        "home",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Search",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Square",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Heart",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Profile",
        style: TextStyle(
          fontSize: 49,
        ),
      ),
    )
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScroll() {
    print(_scrollController.offset);
    if (_scrollController.offset < 110) {
      setState(() {
        _showTitle = true;
      });
    } else {
      if (!_showTitle) return;
      setState(() {
        _showTitle = false;
      });
    }
  }
  // ✅ 네비게이션에서 WriteScreen을 바텀시트로 띄우는 함수

  void showWriteScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false, //Flutter 3.9 이상이면 자동 핸들 추가 가능
      builder: (context) => const WriteScreen(),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((_onScroll));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //화면들 state가 사라지는 방법 계속새로고침임
      //body: screens.elementAt(_selectedIndex),
      //Stack 위젯으로는 다생기고 화면을 보여주고 안보여주고함 stack이 메모리말하는듯
      //offstage true면 화면을 가리고있따.
      body: Scrollbar(
        //스크롤바를 만틈 컨트롤러 넣어줘야함
        controller: _scrollController,
        child: Stack(
          children: [
            Offstage(
              offstage: _selectedIndex != 0,
              child: HomePageScreen(scrollController: _scrollController),
            ),
            Offstage(
              offstage: _selectedIndex != 1,
              child: screens[_selectedIndex],
            ),
            Offstage(
              offstage: _selectedIndex != 2,
              child: screens[_selectedIndex],
            ),
            Offstage(
              offstage: _selectedIndex != 3,
              child: screens[_selectedIndex],
            ),
            Offstage(
                offstage: _selectedIndex != 4, child: const ProfileScreen()),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTap(
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTap(
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(1),
              ),
              NavTap(
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.shareFromSquare,
                onTap: () => showWriteScreen(context),
              ),
              NavTap(
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.heart,
                onTap: () => _onTap(3),
              ),
              NavTap(
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
