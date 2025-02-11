import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 알림 설정 상태를 저장하는 변수 (기본값: false)
  bool _notifications = false;

  // 알림 설정 스위치/체크박스 변경 시 호출되는 함수
  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return; // null 방지
    setState(() {
      _notifications = newValue; // 상태 업데이트
    });
  }

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
          // ✅ SwitchListTile (알림 설정 ON/OFF)
          SwitchListTile.adaptive(
            value: _notifications, // 현재 알림 설정 상태
            onChanged: _onNotificationsChanged, // 변경 시 실행할 함수
            title: const Text("Enable notifications"), // 제목
            subtitle: const Text("Enable notifications"), // 부제목
          ),

          // ✅ CheckboxListTile (체크박스 형태의 알림 설정)
          CheckboxListTile(
            activeColor: Colors.black, // 체크박스 활성화 색상 (검은색)
            value: _notifications, // 현재 상태
            onChanged: _onNotificationsChanged, // 변경 시 실행할 함수
            title: const Text("Enable notifications"), // 제목
          ),

          // ✅ 사용자의 생일 선택 (날짜, 시간, 날짜 범위 다이얼로그)
          ListTile(
            // 리스트 항목 클릭 시 날짜 및 시간 선택 다이얼로그 표시
            onTap: () async {
              // 📌 날짜 선택 다이얼로그 표시
              final date = await showDatePicker(
                context: context, // 다이얼로그를 표시할 컨텍스트
                initialDate: DateTime.now(), // 기본 날짜 (오늘 날짜)
                firstDate: DateTime(1980), // 선택 가능한 가장 이른 날짜
                lastDate: DateTime(2030), // 선택 가능한 가장 마지막 날짜
              );
              print(date); // 선택한 날짜 출력 (null일 수도 있음)

              // 📌 시간 선택 다이얼로그 표시
              final time = await showTimePicker(
                context: context, // 다이얼로그를 표시할 컨텍스트
                initialTime: TimeOfDay.now(), // 기본 시간 (현재 시간)
              );
              print(time); // 선택한 시간 출력 (null일 수도 있음)

              // 📌 날짜 범위 선택 다이얼로그 표시 (기간 예약)
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980), // 선택 가능한 가장 이른 날짜
                lastDate: DateTime(2030), // 선택 가능한 가장 마지막 날짜
                builder: (context, child) {
                  // 다이얼로그의 테마 커스터마이징 (검은색 테마 적용)
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
              print(booking); // 선택한 날짜 범위를 출력 (null일 수도 있음)
            },
            title: const Text("What is your birthday?"), // 리스트 항목 제목
          ),

          // ✅ 기본적인 앱 정보 표시 (Flutter에서 제공하는 기본 설정 타일)
          const AboutListTile(),
        ],
      ),
    );
  }
}
