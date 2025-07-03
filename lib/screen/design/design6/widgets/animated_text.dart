import 'dart:async';

import 'package:flutter/material.dart';
import 'package:typethis/typethis.dart';
import 'package:typewrite_text/typewrite_text.dart';
import 'package:typewritertext/typewritertext.dart';

import 'package:barcontent/screen/design/design6/controller/design6_controller.dart';
import 'package:barcontent/util/helper.dart';

import '../../../../util/exporter.dart';

class AnimatedText extends StatefulWidget {
  String text;
  Color textColor;
  double fontSize;
  int sec;
  AnimatedText({
    Key? key,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.sec,
  }) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TypeWriterController? tcontroller;
  TypeWriterController? t2controller;

  AnimateDesign() {
    Timer(Duration(seconds: widget.sec), () {
      tcontroller = TypeWriterController(
        text: widget.text,
        duration: const Duration(milliseconds: 100),
      );
      setState(() {});
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.sec),
    );
    _controller.forward(); // Start the animation
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return true
        ? TypeThis(
            string: widget.text,
            speed: 1000 * widget.sec,
          )
        : tcontroller != null
            ? TypeWriter(
                controller: tcontroller, // valueController // streamController
                builder: (context, value) {
                  return Text(
                    value.text,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                  );
                })
            : gap();
  }
}
