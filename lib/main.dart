import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

void main() async {
  // ✅ Flutter 엔진이 초기화되도록 보장 (비동기 코드 사용 가능)
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ 앱을 세로 모드로 고정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(const TikTokApp()); // 앱 실행
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ 디버그 배너 제거
      title: 'TikTok Clone', // ✅ 앱 이름 설정
      themeMode: ThemeMode.system, // ✅ 시스템 다크/라이트 모드 따라감

      // ✅ 라이트 모드 테마 설정
      theme: ThemeData(
        textTheme: GoogleFonts.itimTextTheme(),
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
          elevation: 0, // 그림자 효과 없음
          titleTextStyle: TextStyle(
            color: Colors.black, // 제목 색상 (검정)
            fontSize: Sizes.size16 + Sizes.size2, // 제목 폰트 크기
            fontWeight: FontWeight.w600, // 글씨 두께 (Semi-Bold)
          ),
        ),
      ),

      // ✅ 다크 모드 테마 설정
      darkTheme: ThemeData(
        textTheme: GoogleFonts.itimTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        brightness: Brightness.dark, // 어두운 테마
        scaffoldBackgroundColor: Colors.black, // 배경색 검정
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900, // 하단 바 색상 (짙은 회색)
        ),
        primaryColor: const Color(0xFFE9435A), // 기본 색상 (빨간색)
      ),

      home: const SignUpScreen(), // ✅ 앱 첫 화면을 회원가입 화면으로 설정
    );
  }
}
