import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/clone_assignment/features/users/lepos/setting_config_repo.dart';
import 'package:tiktok_clone/clone_assignment/features/users/view_models/setting_config_vm.dart';
import 'package:tiktok_clone/clone_assignment/router.dart' show router;

import '../constants/sizes.dart';

void main() async {
  // ✅ Flutter 엔진이 초기화되도록 보장 (비동기 코드 사용 가능)
  WidgetsFlutterBinding.ensureInitialized();

  // 📌 `SharedPreferences` 인스턴스를 생성하여 로컬 저장소 사용 준비
  final preferences = await SharedPreferences.getInstance();

// 📌 `PlaybackConfigRepository`에 `SharedPreferences`를 주입하여 데이터 저장 및 불러오기 가능하도록 설정
  final repository = SettingConfigRepository(preferences);

// ✅ `MultiProvider`를 사용하여 여러 개의 `Provider`를 앱 전체에 주입
  runApp(
    ProviderScope(
      overrides: [
        // 🔥 `ChangeNotifierProvider`를 사용하여 `SettingConfigViewModel`을 앱 전역에서 사용 가능하게 만듦
        settingConfigProvider
            .overrideWith(() => SettingConfigViewModel(repository))
      ],
      child: const XClone(), // 📌 `TikTokApp` 실행 (앱 시작)
    ),
  );
}

class XClone extends ConsumerWidget {
  const XClone({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // darkMode 값에 따라 테마 모드를 결정합니다.

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false, // ✅ 디버그 배너 제거
      title: 'Clone',
      themeMode: ref.watch(settingConfigProvider).darkMode
          ? ThemeMode.dark
          : ThemeMode.light,
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
