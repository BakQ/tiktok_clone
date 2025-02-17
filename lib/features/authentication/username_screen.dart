import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  static String routeName = "/username";
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<UsernameScreen> {
  final TextEditingController _usernamecontroller = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();
    //
    _usernamecontroller.addListener(() {
      _username = _usernamecontroller.text;
      setState(() {});
    });
  }

  //dispose 할때 usernamecontroller의 위젯을 삭제해주야 한다
  // 삭제안하면 앱이 메모리 풀로 박살나고 말거다.
  //그리고 super.dispose()를 밑에 두는게 깔끔하게 제거되는거다. initState는 위에
  @override
  void dispose() {
    _usernamecontroller.dispose();
    super.dispose();
  }

  //StatefulWidget 위젯에서는 context를 안받아도 된다 context는 항상 static처럼존재한다.
  void onNextTap() {
    if (_username.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    ); // MaterialPageRoute
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              //글자입력 정보 받아가는컨트롤러
              controller: _usernamecontroller,
              decoration: InputDecoration(
                //input창에 글나오게하는거
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v28,
            //부모 전체크기만큼 사이즈박스 만든다.
            GestureDetector(
                onTap: onNextTap,
                child: FormButton(disabled: _username.isEmpty))
          ],
        ),
      ),
    );
  }
}
