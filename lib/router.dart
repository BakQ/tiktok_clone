import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

import 'features/authentication/email_screen.dart';
import 'features/authentication/login_screen.dart';
import 'features/authentication/username_screen.dart';
import 'features/users/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    // ✅ 회원가입 루트 ("/signup")
    GoRoute(
      name: SignUpScreen.routeName, // 라우트의 이름 (명시적으로 사용 가능)
      path: SignUpScreen.routeURL, // 실제 URL 경로 (예: "/signup")
      builder: (context, state) =>
          const SignUpScreen(), // 빌더 함수: SignUpScreen 표시

      // ✅ 하위 라우트 ("/signup/username")
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL, // 경로: "/signup/username"
          name: UsernameScreen.routeName, // 라우트 이름
          builder: (context, state) => const UsernameScreen(), // 사용자 이름 입력 화면

          // ✅ 하위 라우트 ("/signup/username/email")
          routes: [
            GoRoute(
              name: EmailScreen.routeName, // 라우트 이름
              path: EmailScreen.routeURL, // 경로: "/signup/username/email"
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username); // 전달된 username 사용
              },
            ),
          ],
        ),
      ],
    ),

    /* 
      ✅ 로그인 화면 라우트 ("/login") - 현재는 주석 처리됨
      - 로그인 화면을 이동할 수 있도록 설정
      - 나중에 필요할 때 주석 해제 가능
    */
    /* 
    GoRoute(
      path: LoginScreen.routeName, // 경로: "/login"
      builder: (context, state) => const LoginScreen(), // 로그인 화면 빌더
    ), 
    */

    /* 
      ✅ 사용자 이름 입력 화면을 위한 커스텀 애니메이션 라우트 ("/username_screen") - 현재는 주석 처리됨
      - `CustomTransitionPage`를 사용하여 사용자 정의 애니메이션 적용
      - 페이드 인/아웃 + 크기 변경 애니메이션 포함
      - 기본 `builder` 대신 `pageBuilder` 사용하여 애니메이션 적용
    */
    /*
    GoRoute(
      name: "username_screen", // 라우트 이름 (명시적 사용 가능)
      path: UsernameScreen.routeName, // 경로: "/username_screen"
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UsernameScreen(), // 사용자 이름 입력 화면
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation, // 페이드 인/아웃 애니메이션
              child: ScaleTransition(
                scale: animation, // 크기 변환 애니메이션
                child: child, // 애니메이션이 적용될 화면
              ),
            );
          },
        );
      },
    ),
    */
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.pathParameters['username']; // URL에서 username 추출
        final tab = state.uri.queryParameters["show"]; // "?show=likes" 데이터 추출
        return UserProfileScreen(username: username!, tab: tab!);
      },
    ),
  ],
);
