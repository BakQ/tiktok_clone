import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    //if (_formKey.currentState != null) {
    //  _formKey.currentState!.validate();
    //}
    //위에 처럼도 쓰지만 다트언어로
    //_formKey.currentState?.validate();
    //_formKey.currentState?.validate()는 폼 내의 모든 입력 필드를 검증(validator 실행)하여 입력 값이 유효한지 확인하고, 유효하면 true, 그렇지 않으면 false를 반환합니다.
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const InterestsScreen(),
          ),
        ); // MaterialPageRoute
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                //속성을 통해 입력된 값이 유효한지 확인하는 간단한 검증 로직을 포함합니다.
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Plase write your email";
                  }
                  //return 'i dont like your email';
                  //return null 을 주면 이상없는게 된다.?
                  //validator에서 null을 반환하면 입력 값이 유효하다고 간주되며, 폼 검증이 성공하면 onSaved 함수가 호출되어 데이터를 저장할 수 있습니다.
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'wrong password';
                  }
                  return null;
                },
              ),
              Gaps.v28,
              GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(disabled: false)),
            ],
          ),
        ),
      ),
    );
  }
}
