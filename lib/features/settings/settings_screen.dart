import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱의 기본적인 레이아웃을 제공하는 Scaffold
      appBar: AppBar(
        title: const Text('Settings'), // 상단 앱바의 제목
      ),

      // 세팅 화면의 내용 (리스트 형태)
      body: ListView(
        children: [
          // 리스트의 한 항목 (ListTile)
          ListTile(
            // flutter showAboutDialog 가 라이센서에 대한 정보를 다만들어준다 .
            onTap: () => showAboutDialog(
              context: context, // 다이얼로그를 표시할 컨텍스트
              applicationVersion: "1.0", // 앱 버전 정보
              applicationLegalese:
                  "All rights reserved. Please don't copy me.", // 저작권 관련 안내
            ),
            title: const Text(
              "About", // 항목 제목
              style: TextStyle(
                fontWeight: FontWeight.w600, // 글자 두껍게 설정
              ),
            ),
            subtitle: const Text("About this app....."),
          ),

          // Flutter에서 기본 제공하는 앱 정보 타일

          const AboutListTile(),
        ],
      ),
    );
  }
}
