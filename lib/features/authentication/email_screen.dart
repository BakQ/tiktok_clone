import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
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
              "What is your email?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),

            Gaps.v16,
            TextField(
              //글자입력 정보 받아가는컨트롤러
              controller: _usernamecontroller,
              decoration: InputDecoration(
                //input창에 글나오게하는거
                hintText: "Email",
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
            FormButton(disabled: _username.isEmpty)
          ],
        ),
      ),
    );
  }
}
