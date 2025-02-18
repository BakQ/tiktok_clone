import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/home_page_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/clone_assignment/features/users/settings_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/users/user_profile_screen.dart';

// 공통 ScrollController 선언
final ScrollController _scrollController = ScrollController();
int _selectedIndex = 0;

// go_router 설정
final GoRouter router = GoRouter(
  routes: [
    // ShellRoute: Scaffold, Scrollbar, BottomNavigationBar 등 공통 레이아웃을 유지
    ShellRoute(
      builder: (context, state, child) {
        final bottomAppBarColor =
            Theme.of(context).bottomAppBarTheme.color ?? Colors.white;

        void onTap(int index) {
          _selectedIndex = index;
          switch (index) {
            case 0:
              context.go(HomePageScreen.routeURL);
              break;
            case 1:
              context.go(Screen1.routeURL);
              break;
            case 2:
              context.go(Screen2.routeURL);
              break;
            case 3:
              context.go(Screen3.routeURL);
              break;
            case 4:
              context.go(ProfileScreen.routeURL);
              break;
          }
        }

        return Scaffold(
          body: Scrollbar(
            controller: _scrollController,
            child: child, // 현재 선택된 화면이 표시됩니다.
          ),
          bottomNavigationBar: BottomAppBar(
            color: bottomAppBarColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavTap(
                    isSelected: _selectedIndex == 0,
                    icon: FontAwesomeIcons.house,
                    onTap: () => onTap(0),
                  ),
                  NavTap(
                    isSelected: _selectedIndex == 1,
                    icon: FontAwesomeIcons.magnifyingGlass,
                    onTap: () => onTap(1),
                  ),
                  NavTap(
                    isSelected: _selectedIndex == 2,
                    icon: FontAwesomeIcons.shareFromSquare,
                    //onTap: () => showWriteScreen(context),
                    onTap: () => onTap(2),
                  ),
                  NavTap(
                    isSelected: _selectedIndex == 3,
                    icon: FontAwesomeIcons.heart,
                    onTap: () => onTap(3),
                  ),
                  NavTap(
                    isSelected: _selectedIndex == 4,
                    icon: FontAwesomeIcons.user,
                    onTap: () => onTap(4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          name: HomePageScreen.routeName,
          path: HomePageScreen.routeURL,
          builder: (context, state) => HomePageScreen(
            scrollController: _scrollController,
          ),
        ),
        GoRoute(
          name: Screen1.routeName,
          path: Screen1.routeURL,
          builder: (context, state) => const Screen1(),
        ),
        GoRoute(
          name: Screen2.routeName,
          path: Screen2.routeURL,
          builder: (context, state) => const Screen2(),
        ),
        GoRoute(
          name: Screen3.routeName,
          path: Screen3.routeURL,
          builder: (context, state) => const Screen3(),
        ),
        GoRoute(
          name: ProfileScreen.routeName,
          path: ProfileScreen.routeURL,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          name: SettingsScreen.routeName,
          path: SettingsScreen.routeURL,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class Screen1 extends StatelessWidget {
  static const String routeName = 'screen1';
  static const String routeURL = '/screen1';

  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Screen 1'));
  }
}

class Screen2 extends StatelessWidget {
  static const String routeName = 'screen2';
  static const String routeURL = '/screen2';

  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Screen 2'));
  }
}

class Screen3 extends StatelessWidget {
  static const String routeName = 'screen3';
  static const String routeURL = '/screen3';

  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Screen 3'));
  }
}
