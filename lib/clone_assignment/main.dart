import 'package:flutter/material.dart';
import 'package:tiktok_clone/clone_assignment/router.dart' show router;

import '../constants/sizes.dart';

void main() {
  runApp(const XClone());
}

class XClone extends StatelessWidget {
  const XClone({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false, // ✅ 디버그 배너 제거
      title: 'Clone',
      themeMode: ThemeMode.system, // ✅ 시스템 다크/라이트 모드 따라감
      // ✅ 라이트 모드 테마 설정
      theme: ThemeData(
        useMaterial3: true,
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light, // 밝은 테마

        scaffoldBackgroundColor: Colors.white, // 배경색 흰색
        primaryColor: const Color(0xFFE9435A), // 기본 색상 (빨간색)

        // ✅ 텍스트 입력 시 커서 색상 지정
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A), // 빨간색 커서
        ),

        splashColor: Colors.transparent, // 클릭 시 스플래시 효과 제거

        // ✅ 앱바 테마 설정
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black, // 아이콘 & 글씨 색상 (검정)
          backgroundColor: Colors.white, // 배경색 (흰색)
          surfaceTintColor: Colors.white,
          elevation: 0, // 그림자 효과 없음
          titleTextStyle: TextStyle(
            color: Colors.black, // 제목 색상 (검정)
            fontSize: Sizes.size16 + Sizes.size2, // 제목 폰트 크기
            fontWeight: FontWeight.w600, // 글씨 두께 (Semi-Bold)
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Colors.black,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),

      // ✅ 다크 모드 테마 설정
      darkTheme: ThemeData(
        useMaterial3: true,
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark, // 어두운 테마
        scaffoldBackgroundColor: Colors.black, // 배경색 검정
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900, // 하단 바 색상 (짙은 회색)
        ),
        primaryColor: const Color(0xFFE9435A), // 기본 색상 (빨간색)
      ),
      //home: const SignUpScreen(),
      // home: const MainNavigationScreen(),
    );
  }
}
