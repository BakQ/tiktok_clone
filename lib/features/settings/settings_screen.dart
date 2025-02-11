import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 기본적인 화면 레이아웃을 제공하는 Scaffold
      appBar: AppBar(
        title: const Text('Settings'), // 앱 상단의 제목
      ),

      // 세팅 화면의 내용 (리스트 형태)
      body: ListView(
        children: [
          // 리스트의 한 항목 (ListTile)
          ListTile(
            // 사용자가 리스트를 클릭하면 날짜 및 시간 선택 다이얼로그가 표시됨
            onTap: () async {
              // 날짜 선택 다이얼로그 표시
              final date = await showDatePicker(
                context: context, // 다이얼로그를 표시할 컨텍스트
                initialDate: DateTime.now(), // 기본 날짜 (오늘 날짜)
                firstDate: DateTime(1980), // 선택 가능한 가장 이른 날짜
                lastDate: DateTime(2030), // 선택 가능한 가장 마지막 날짜
              );
              //날짜를 선택안하면 null리턴
              print(date); // 선택한 날짜를 출력

              // 시간 선택 다이얼로그 표시
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(), // 기본 시간 (현재 시간)
              );
              print(time); // 선택한 시간을 출력

              // 날짜 범위 선택 다이얼로그 표시
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980), // 선택 가능한 가장 이른 날짜
                lastDate: DateTime(2030), // 선택 가능한 가장 마지막 날짜
                builder: (context, child) {
                  // 다이얼로그의 테마 커스터마이징
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white, // 텍스트 색상: 흰색
                        backgroundColor: Colors.black, // 배경색: 검은색
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              print(booking); // 선택한 날짜 범위를 출력
            },
            title: const Text("What is your birthday?"), // 리스트 항목 제목
          ),

          // Flutter에서 제공하는 기본 앱 정보 타일
          const AboutListTile(),
        ],
      ),
    );
  }
}
