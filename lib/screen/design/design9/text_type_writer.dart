import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typewritertext/typewritertext.dart';

import 'package:barcontent/util/helper.dart';

class TextTypeWriter extends StatefulWidget {
  String text;
  TextStyle style;
  int typingSpeed;
  TextAlign textAlign;
  TextTypeWriter({
    Key? key,
    required this.text,
    required this.style,
    required this.typingSpeed,
    required this.textAlign,
  }) : super(key: key);

  @override
  State<TextTypeWriter> createState() => _TextTypeWriterState();
}

class _TextTypeWriterState extends State<TextTypeWriter> {
  TypeWriterController? tcontroller;

  AnimateDesign() {
    tcontroller = TypeWriterController(
      text: widget.text,
      duration: Duration(milliseconds: widget.typingSpeed),
    );
    setState(() {});
    // Start the animation
  }

  @override
  void initState() {
    AnimateDesign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return tcontroller != null
        ? Container(
            alignment: Alignment.centerLeft,
            child: TypeWriter(
              controller: tcontroller, // valueController // streamController
              builder: (context, value) {
                return Text(
                  value.text,
                  style: widget.style,
                  textAlign: widget.textAlign,
                );
              },
            ),
          )
        : gap();
  }
}
