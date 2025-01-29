import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InterestDetailButton extends StatefulWidget {
  const InterestDetailButton({
    super.key,
    required this.interest,
    required this.isSelected,
  });

  final String interest;
  final bool isSelected;

  @override
  State<InterestDetailButton> createState() => _InterestDetailButtonState();
}

class _InterestDetailButtonState extends State<InterestDetailButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color:
              widget.isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Text(widget.interest,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isSelected ? Colors.white : Colors.black,
            )),
      ),
    );
  }
}
