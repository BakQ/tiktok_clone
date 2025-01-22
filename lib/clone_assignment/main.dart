import 'package:flutter/material.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/sign_up_screen.dart';

import '../constants/sizes.dart';

void main() {
  runApp(const XClone());
}

class XClone extends StatelessWidget {
  const XClone({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clone',
      theme: ThemeData(
        //여기서 scaffold 색을 한번에 지정해줄수있다.
        scaffoldBackgroundColor: Colors.white,
        //appbar도 메인에서 전부 설정해줄수있다.
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          //title text sytle도 설정가능하다.
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600),
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}
