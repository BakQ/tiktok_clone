import 'package:flutter/material.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
    required this.isSelected,
  });

  final String interest;
  final bool isSelected;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width:
                MediaQuery.of(context).size.width / 2 - 20, // 화면 너비의 절반에서 여백 제외
            height: Sizes.size80, // 버튼 높이 설정
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size8, // 조정된 패딩
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size20), // 둥근 모서리
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
              ),
              boxShadow: [
                if (widget.isSelected) // 선택된 경우만 그림자 적용
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: Align(
              alignment: Alignment.bottomLeft, // 텍스트를 왼쪽 아래로 정렬
              child: Text(
                widget.interest,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
          if (widget.isSelected)
            const Positioned(
              top: 8,
              right: 8,
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
