import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Flutter 엔진과 위젯 바인딩 초기화

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // ✅ Firebase 초기화 (플랫폼별 설정 적용)
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // ✅ 앱을 세로 모드로만 실행하도록 설정
    ],
  );

  final preferences =
      await SharedPreferences.getInstance(); // ✅ SharedPreferences 인스턴스 가져오기
  final repository = PlaybackConfigRepository(preferences); // ✅ 설정 데이터 관리 객체 생성

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
            () => PlaybackConfigViewModel(repository)) // ✅ Riverpod 상태 주입
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends ConsumerWidget {
  // ✅ `ConsumerWidget`을 사용하여 Riverpod 상태 관리
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider), // ✅ Riverpod을 사용하여 라우팅 설정
      debugShowCheckedModeBanner: false, // ✅ 디버그 배너 숨김
      title: 'TikTok Clone', // ✅ 앱 타이틀 설정

      // 🌍 다국어(Localization) 지원 설정
      localizationsDelegates: const [
        S.delegate, // ✅ 앱의 다국어 번역 설정 (`generated/l10n.dart` 사용)
        GlobalWidgetsLocalizations.delegate, // ✅ 기본적인 Flutter 위젯 로컬라이제이션 지원
        GlobalCupertinoLocalizations.delegate, // ✅ iOS 스타일의 로컬라이제이션 지원
        GlobalMaterialLocalizations.delegate, // ✅ Material 디자인의 로컬라이제이션 지원
      ],
      supportedLocales: const [
        Locale('en'), // ✅ 영어 지원
        Locale('ko'), // ✅ 한국어 지원
      ],

      themeMode: ThemeMode.system, // ✅ 시스템 다크/라이트 모드 자동 적용

      // 🌞 라이트 모드 테마 설정
      theme: ThemeData(
        useMaterial3: true, // ✅ Material 3 적용
        textTheme: Typography.blackMountainView, // ✅ 기본 텍스트 스타일 설정
        brightness: Brightness.light, // ✅ 밝은 테마 (라이트 모드)
        scaffoldBackgroundColor: Colors.white, // ✅ 기본 배경색 흰색
        primaryColor: const Color(0xFFE9435A), // ✅ 메인 컬러 (빨간색)
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A), // ✅ 텍스트 커서 색상 지정
        ),
        splashColor: Colors.transparent, // ✅ 터치 효과 제거
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black, // ✅ AppBar 아이콘 색상 (검정)
          backgroundColor: Colors.white, // ✅ AppBar 배경색 (흰색)
          surfaceTintColor: Colors.white, // ✅ Material3에서 적용되는 효과 방지
          elevation: 0, // ✅ 그림자 제거
          titleTextStyle: TextStyle(
            color: Colors.black, // ✅ AppBar 제목 색상 (검정)
            fontSize: Sizes.size16 + Sizes.size2, // ✅ 제목 폰트 크기
            fontWeight: FontWeight.w600, // ✅ 굵은 글씨
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

      // 🌙 다크 모드 테마 설정
      darkTheme: ThemeData(
        useMaterial3: true, // ✅ Material 3 적용
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView, // ✅ 다크 모드에서는 흰색 텍스트 사용
        brightness: Brightness.dark, // ✅ 어두운 테마 (다크 모드)
        scaffoldBackgroundColor: Colors.black, // ✅ 배경색 검정
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.grey.shade900, // ✅ AppBar 반투명 효과 방지
          backgroundColor: Colors.grey.shade900, // ✅ AppBar 배경 어둡게
          foregroundColor: Colors.white, // ✅ 아이콘 및 제목 색상 흰색
          titleTextStyle: const TextStyle(
            color: Colors.white, // ✅ 다크 모드에서 AppBar 제목 색상 흰색
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100, // ✅ AppBar 아이콘 색상
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100, // ✅ 기본 아이콘 색상 설정
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900, // ✅ 하단 앱바 배경색 어둡게 설정
        ),
        primaryColor: const Color(0xFFE9435A), // ✅ 다크 모드에서도 동일한 빨간색 포인트 컬러 유지
      ),
    );
  }
}
