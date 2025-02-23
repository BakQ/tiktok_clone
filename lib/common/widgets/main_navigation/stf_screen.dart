import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StfScreen extends StatefulWidget {
  const StfScreen({super.key});

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  var count = 0;
  void _onPresseIcon() {
    count++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
          IconButton(
            onPressed: _onPresseIcon,
            icon: const Icon(FontAwesomeIcons.plus),
          )
        ],
      ),
    );
  }
}
