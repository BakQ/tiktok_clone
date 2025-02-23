import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

/// ✅ `routerProvider`는 Riverpod의 `Provider`를 사용하여 GoRouter 인스턴스를 생성
final routerProvider = Provider((ref) {
  //  ref.watch(authState);
  return GoRouter(
    initialLocation: "/home", // ✅ 초기 라우트 설정 (앱 실행 시 "/home"으로 시작)

    /// 📌 로그인 상태에 따라 페이지 접근 제한 (redirect 설정)
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn; // ✅ 로그인 상태 가져오기

      // ✅ 로그인되지 않은 경우, 회원가입 또는 로그인 페이지가 아니라면 회원가입 페이지로 리다이렉트
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != LoginScreen.routeURL) {
          return SignUpScreen.routeURL; // 🔄 로그인되지 않았으면 회원가입 페이지로 이동
        }
      }
      return null; // ✅ 로그인된 경우 리다이렉트 없음
    },

    /// 📌 앱의 전체 라우트 설정
    routes: [
      // ✅ 회원가입 페이지
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),

      // ✅ 로그인 페이지
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),

      // ✅ 관심사 선택 페이지 (온보딩 과정)
      GoRoute(
        name: InterestsScreen.routeName,
        path: InterestsScreen.routeURL,
        builder: (context, state) => const InterestsScreen(),
      ),

      // ✅ 메인 네비게이션 화면 (홈, 검색, 알림, 프로필)
      GoRoute(
        path:
            "/:tab(home|discover|inbox|profile)", // 📌 `home`, `discover`, `inbox`, `profile` 중 하나의 탭으로 이동
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters["tab"]!; // ✅ 선택한 탭의 이름을 가져오기
          return MainNavigationScreen(tab: tab); // ✅ 선택한 탭을 보여주는 화면 반환
        },
      ),

      // ✅ 활동 페이지 (알림 화면)
      GoRoute(
        name: ActivityScreen.routeName,
        path: ActivityScreen.routeURL,
        builder: (context, state) => const ActivityScreen(),
      ),

      // ✅ 채팅 목록 화면
      GoRoute(
        name: ChatsScreen.routeName,
        path: ChatsScreen.routeURL,
        builder: (context, state) => const ChatsScreen(),

        /// 🔽 **하위 라우트 (채팅 상세 화면)**
        routes: [
          GoRoute(
            name: ChatDetailScreen.routeName,
            path: ChatDetailScreen.routeURL,
            builder: (context, state) {
              final chatId =
                  state.pathParameters["chatId"]!; // ✅ URL에서 채팅 ID 가져오기
              return ChatDetailScreen(
                  chatId: chatId); // ✅ 채팅 ID를 전달하여 상세 화면 띄우기
            },
          )
        ],
      ),

      // ✅ 비디오 녹화 화면 (애니메이션 효과 포함)
      GoRoute(
        path: VideoRecordingScreen.routeURL,
        name: VideoRecordingScreen.routeName,

        /// 📌 커스텀 애니메이션 적용 (아래에서 위로 슬라이드)
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration:
              const Duration(milliseconds: 200), // ✅ 애니메이션 지속 시간 (0.2초)
          child: const VideoRecordingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween(
              begin: const Offset(0, 1), // ✅ 아래에서 시작
              end: Offset.zero, // ✅ 최종 위치
            ).animate(animation);
            return SlideTransition(
              position: position,
              child: child, // ✅ 슬라이드 애니메이션 적용된 화면 반환
            );
          },
        ),
      )
    ],
  );
});
