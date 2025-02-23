import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/login_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/home_page_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/write_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/users/views/privacy_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/users/views/settings_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/users/views/user_profile_screen.dart';

// 공통 ScrollController 선언
final ScrollController _scrollController = ScrollController();
int _selectedIndex = 0;

// go_router 설정
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: LoginScreen.routeURL, // 앱 실행 시 초기 경로 설정
    /// 로그인 상태에 따라 페이지 접근 제한 (redirect 설정)
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn; // 로그인 상태 가져오기
      final isAuthPage = state.matchedLocation == SignUpScreen.routeURL ||
          state.matchedLocation == LoginScreen.routeURL;
      // 로그인되지 않은 경우, 인증 화면이 아니라면 로그인 화면으로 리다이렉트
      if (!isLoggedIn && !isAuthPage) {
        return LoginScreen.routeURL; // 예: "/login"
      }
      return null; // 조건에 맞으면 리다이렉트 없음
    },
    routes: [
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      // 인증 관련 라우트 (ShellRoute 외부에 정의하여 독립적 화면으로 노출)
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),

      // 메인 앱 화면들을 위한 ShellRoute (로그인 상태일 때만 접근됨)
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
                context.go(SearchScreen.routeURL);
                break;
              case 2:
                // WriteScreen은 모달로 띄움
                break;
              case 3:
                context.go(ActivityScreen.routeURL);
                break;
              case 4:
                context.go(ProfileScreen.routeURL);
                break;
            }
          }

          // 네비게이션에서 WriteScreen을 바텀시트로 띄우는 함수
          void showWriteScreen(BuildContext context) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: false,
              builder: (context) => const WriteScreen(),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
            );
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
                      onTap: () => showWriteScreen(context),
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
            name: SearchScreen.routeName,
            path: SearchScreen.routeURL,
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            name: Screen3.routeName,
            path: Screen3.routeURL,
            builder: (context, state) => const Screen3(),
          ),
          GoRoute(
            name: ActivityScreen.routeName,
            path: ActivityScreen.routeURL,
            builder: (context, state) => const ActivityScreen(),
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
            routes: [
              GoRoute(
                name: PrivacyScreen.routeName,
                path: PrivacyScreen.routeURL,
                builder: (context, state) => const PrivacyScreen(),
              )
            ],
          ),
        ],
      ),
    ],
  );
});

// 나머지 화면들
class SearchScreen extends StatelessWidget {
  static const String routeName = 'search';
  static const String routeURL = '/search';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Screen'));
  }
}

class ActivityScreen extends StatelessWidget {
  static const String routeName = 'activity';
  static const String routeURL = '/activity';

  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Activity Screen'));
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
