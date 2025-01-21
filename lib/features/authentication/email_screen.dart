import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  //TextEditingController는 TextField 위젯에 입력을 감지해서 가져오는 컨트롤러
  final TextEditingController _emailcontroller = TextEditingController();

  String _email = "";

  @override
  void initState() {
    super.initState();
    //
    _emailcontroller.addListener(() {
      _email = _emailcontroller.text;
      setState(() {});
    });
  }

  //dispose 할때 usernamecontroller의 위젯을 삭제해주야 한다
  // 삭제안하면 앱이 메모리 풀로 박살나고 말거다.
  //그리고 super.dispose()를 밑에 두는게 깔끔하게 제거되는거다. initState는 위에
  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  //정규식으로 이메일 체크
  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    //FocusScope는 Flutter에서 **입력 포커스(focus)**를 관리하는 클래스
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    print('dkdk');
    if (_email.isEmpty || _isEmailValid() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                controller: _emailcontroller,
                //키보드 인풋 타입도 설정할수있다. 졸라 기능많네
                keyboardType: TextInputType.emailAddress,
                //자동완성기능도 넣고 뺄수있네 !!!
                autocorrect: false,
                //키보드의 "완료"(Enter) 버튼을 누를 때 실행되는 옵션
                onEditingComplete: _onSubmit,
                decoration: InputDecoration(
                  //input창에 글나오게하는거
                  hintText: "Email",
                  errorText: _isEmailValid(),
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
              GestureDetector(
                  onTap: _onSubmit,
                  //부모 전체크기만큼 사이즈박스 만든다.
                  child: FormButton(
                      disabled: _email.isEmpty || _isEmailValid() != null))
            ],
          ),
        ),
      ),
    );
  }
}
