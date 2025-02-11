import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱의 기본 구조를 제공하는 Scaffold
      appBar: AppBar(
        title: const Text('Settings'), // 상단 앱바 제목
      ),

      // 리스트를 휠(롤러) 형태로 스크롤할 수 있는 ListWheelScrollView 사용
      body: ListWheelScrollView(
        diameterRatio: 1.5, // 휠의 곡률을 결정 (값이 클수록 더 평평한 원형 리스트가 됨)
        offAxisFraction: 1.5, // 리스트의 중심에서 얼마나 이동할지를 조정 (양수: 오른쪽, 음수: 왼쪽)
        itemExtent: 200, // 각 아이템의 높이 지정 (픽셀 단위)

        children: [
          for (var x in [1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1])
            FractionallySizedBox(
              widthFactor: 1, // 부모의 100% 너비 차지
              child: Container(
                color: Colors.teal, // 배경색 지정
                alignment: Alignment.center, // 텍스트 중앙 정렬
                child: const Text(
                  'Pick me', // 표시될 텍스트
                  style: TextStyle(
                    color: Colors.white, // 텍스트 색상 흰색
                    fontSize: 39, // 폰트 크기
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
