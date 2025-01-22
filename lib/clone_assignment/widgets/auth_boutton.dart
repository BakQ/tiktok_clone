import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/sizes.dart';

class AuthBoutton extends StatelessWidget {
  final String text;
  final FaIcon? icon;
  final Color? backGroudColor;
  final Color? textColor;

  const AuthBoutton({
    super.key,
    required this.text,
    this.icon,
    this.backGroudColor,
    this.textColor,
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
          borderRadius: BorderRadius.circular(100),
          color: backGroudColor ??
              Theme.of(context).scaffoldBackgroundColor, // 조건부로 색상 지정
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ), //
        ), // BoxDecoration
        //여기서 스택은 자식 위젯들을 겹치게할수있는거다 로우나 컬럼과 다르게 겹치게해준다.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
                child: icon,
              ),

            //여기서는 나머지 영역을 전부 차지해버릴려고 expanded 를사용 // 하지만 여기서 stack은 사용해서 필요가없어짐
            Text(
              text,
              style: TextStyle(
                color:
                    textColor ?? Theme.of(context).appBarTheme.foregroundColor,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.bold,
              ), // TextStyle textAlign: TextAlign. center,
              textAlign: TextAlign.center,
            ),
          ],
        ), // Text
      ), // Container
    ); // FractionallySizedBox
  }
}
