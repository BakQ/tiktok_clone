import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _setTextFieldDate(initialDate);
  }

  //dispose 할때 usernamecontroller의 위젯을 삭제해주야 한다
  // 삭제안하면 앱이 메모리 풀로 박살나고 말거다.
  //그리고 super.dispose()를 밑에 두는게 깔끔하게 제거되는거다. initState는 위에
  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  //StatefulWidget 위젯에서는 context를 안받아도 된다 context는 항상 static처럼존재한다.
  void onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
        // pushAndRemoveUntil은 앞에 있었던 화면을 제거해주는 함수다.
        MaterialPageRoute(
          builder: (context) => const InterestsScreen(),
        ),
        (route) => false // 리턴값에 따라서 뒤로가기 버튼이 생길수도 있고 없을수도있다.
        ); // MateerialPageRoute
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
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
              "When's Your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown pulbicly",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              //글자입력 정보 받아가는컨트롤러
              controller: _birthdayController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
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
              child: const FormButton(disabled: false),
            )
          ],
        ),
      ),
      //아래 고정시키는 위젯 저번과제에 이거없어서 진짜 힘들었는데 ...
      bottomNavigationBar: SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: initialDate,
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
