import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "settings";
  static String routeURL = "/settings";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ✅ 알림 설정 상태를 저장하는 변수 (기본값: false)
  bool _notifications = false;

  // ✅ 알림 설정 스위치/체크박스 변경 시 호출되는 함수
  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return; // null 값 방지
    setState(() {
      _notifications = newValue; // 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ 앱 기본 레이아웃 제공 (AppBar 포함)
      appBar: AppBar(
        title: const Text('Settings'), // 앱 상단 제목
      ),

      // ✅ 설정 화면의 내용 (리스트 형태)
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) => {},
            title: const Text("Mute video"),
            subtitle: const Text("Video will be muted by default."),
          ),
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) => {},
            title: const Text("Autoplay"),
            subtitle: const Text("Video will start playing automatically."),
          ),

          // ✅ SwitchListTile (알림 설정 ON/OFF)
          SwitchListTile.adaptive(
            value: _notifications, // 현재 알림 설정 상태
            onChanged: _onNotificationsChanged, // 변경 시 실행할 함수
            title: const Text("Enable notifications"), // 제목
            subtitle: const Text("They will be cute."), // 부제목
          ),

          // ✅ CheckboxListTile (체크박스 형태의 설정)
          CheckboxListTile(
            activeColor: Colors.black, // 체크박스 활성화 색상 (검은색)
            value: _notifications, // 현재 상태
            onChanged: _onNotificationsChanged, // 변경 시 실행할 함수
            title: const Text("Marketing emails"), // 제목
            subtitle: const Text("We won't spam you."), // 부제목
          ),

          // ✅ 사용자의 생일 선택 (날짜, 시간, 날짜 범위 다이얼로그)
          ListTile(
            // 리스트 클릭 시 날짜 및 시간 선택 다이얼로그 표시
            onTap: () async {
              // 📌 날짜 선택 다이얼로그 표시
              final date = await showDatePicker(
                context: context, // 다이얼로그를 표시할 컨텍스트
                initialDate: DateTime.now(), // 기본 날짜 (오늘)
                firstDate: DateTime(1980), // 최소 선택 가능 날짜
                lastDate: DateTime(2030), // 최대 선택 가능 날짜
              );
              print(date); // 선택한 날짜 출력

              // 📌 시간 선택 다이얼로그 표시
              final time = await showTimePicker(
                context: context, // 다이얼로그를 표시할 컨텍스트
                initialTime: TimeOfDay.now(), // 기본 시간 (현재)
              );
              print(time); // 선택한 시간 출력

              // 📌 날짜 범위 선택 다이얼로그 (예약 등)
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  // 다이얼로그 테마 변경 (검은색 스타일)
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
              print(booking); // 선택한 날짜 범위 출력
            },
            title: const Text("What is your birthday?"), // 리스트 항목 제목
            subtitle: const Text("I need to know!"), // 부제목
          ),

          // ✅ iOS 스타일 로그아웃 다이얼로그
          ListTile(
            title: const Text("Log out (iOS)"), // 리스트 항목 제목
            textColor: Colors.red, // 텍스트 색상: 빨간색
            onTap: () {
              // iOS 스타일 다이얼로그 표시 (CupertinoAlertDialog)
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"), // 제목
                  content: const Text("Plx dont go"), // 내용
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
                      child: const Text("No"), // 취소 버튼
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
                      isDestructiveAction: true, // 빨간색 버튼 (위험한 행동 강조)
                      child: const Text("Yes"), // 확인 버튼
                    ),
                  ],
                ),
              );
            },
          ),

          // ✅ Android 스타일 로그아웃 다이얼로그
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.red, // 텍스트 색상: 빨간색
            onTap: () {
              // Android 스타일 다이얼로그 표시 (AlertDialog)
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull), // 해골 아이콘 추가
                  title: const Text("Are you sure?"), // 제목
                  content: const Text("Plx dont go"), // 내용
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
                      icon: const FaIcon(FontAwesomeIcons.car), // 자동차 아이콘 버튼
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
                      child: const Text("Yes"), // 확인 버튼
                    ),
                  ],
                ),
              );
            },
          ),
          // ✅ iOS 스타일의 로그아웃 모달 (하단에서 슬라이드 업)
          ListTile(
            title: const Text("Log out (iOS / Bottom)"), // 리스트 제목
            textColor: Colors.red, // 텍스트 색상 (빨간색)
            onTap: () {
              // 📌 iOS 스타일의 액션 시트 모달 표시 (하단에서 올라옴)
              showCupertinoModalPopup(
                context: context, // 현재 컨텍스트
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"), // 모달 제목
                  message: const Text("Please dooooont gooooo"), // 설명 메시지

                  // 버튼 리스트 (액션 목록)
                  actions: [
                    // ✅ 기본 액션 버튼 (로그아웃 취소)
                    CupertinoActionSheetAction(
                      isDefaultAction: true, // 기본 강조 스타일 적용
                      onPressed: () => Navigator.of(context).pop(), // 모달 닫기
                      child: const Text("Not log out"), // 버튼 텍스트
                    ),

                    // ✅ 파괴적 액션 버튼 (로그아웃 실행)
                    CupertinoActionSheetAction(
                      isDestructiveAction: true, // 빨간색 강조 (위험한 액션 표시)
                      onPressed: () => Navigator.of(context).pop(), // 모달 닫기
                      child: const Text("Yes plz."), // 버튼 텍스트
                    )
                  ],
                ),
              );
            },
          ),

          // ✅ 기본적인 앱 정보 표시 (버전, 라이선스 등)
          const AboutListTile(
            applicationVersion: "1.0", // 앱 버전 정보
            applicationLegalese: "Don't copy me.", // 라이선스 설명
          ),

          // ✅ 추가 앱 정보 타일
          const AboutListTile(),
        ],
      ),
    );
  }
}
