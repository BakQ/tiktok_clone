import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

import 'features/authentication/email_screen.dart';
import 'features/authentication/login_screen.dart';
import 'features/authentication/username_screen.dart';
import 'features/users/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: UsernameScreen.routeName,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: EmailScreen.routeName, // 경로: "/email"
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs; // extra에 전달된 데이터를 가져옴
        return EmailScreen(username: args.username); // 전달받은 username 사용
      },
    ),
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
