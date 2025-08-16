import 'package:flutter/material.dart';

class ThreeDText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color shadowColor;
  final int depth;

  const ThreeDText({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.shadowColor = Colors.black,
    this.depth = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = depth; i > 0; i--)
          Positioned(
            left: i.toDouble(),
            top: i.toDouble(),
            child: Text(
              text,
              style: textStyle.copyWith(
                color: shadowColor
                    .withAlpha(((1 - i / (depth + 1)) * 255).toInt()),
              ),
            ),
          ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
