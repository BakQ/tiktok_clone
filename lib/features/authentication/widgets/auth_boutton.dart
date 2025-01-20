import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthBoutton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthBoutton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox는 부모 크기에 따라서 widthFactor 설정으로 크기가 비례한다.
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.all(
          Sizes.size14,
        ), // EdgeInsets.symmetric
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ), //
        ), // BoxDecoration
        //여기서 스택은 자식 위젯들을 겹치게할수있는거다 로우나 컬럼과 다르게 겹치게해준다.
        child: Stack(
          alignment: Alignment.center,
          children: [
            //여기서 Align은 Stack사용중에 하나의 위젯만 align은 변경하게하는 위젯이다.
            Align(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            //여기서는 나머지 영역을 전부 차지해버릴려고 expanded 를사용 // 하지만 여기서 stack은 사용해서 필요가없어짐
            Text(
              text,
              style: const TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ), // TextStyle textAlign: TextAlign. center,
              textAlign: TextAlign.center,
            ),
          ],
        ), // Text
      ), // Container
    ); // FractionallySizedBox
  }
}
