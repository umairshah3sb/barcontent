import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/screen/design/design15/controller/design15_controller.dart';

class SlideUpPauseDown extends StatefulWidget {
  bool isFirst;
  String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  SlideUpPauseDown({
    Key? key,
    required this.isFirst,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);
  @override
  _SlideUpPauseDownState createState() => _SlideUpPauseDownState();
}

class _SlideUpPauseDownState extends State<SlideUpPauseDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  Design15Controller designcontroller = Get.put(Design15Controller());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600), // smooth slide duration
    );

    _slideAnim = Tween<Offset>(
      begin: Offset(0, 1), // start from bottom of container
      end: Offset(0, 0), // slide into visible area (top)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _startAnimationFlow();
  }

  Future<void> _startAnimationFlow() async {
    // Step 1: Slide up
    Timer(Duration(seconds: widget.isFirst ? 1 : 2), () async {
      await _controller.forward();
    });

    // Step 2: Pause at top
    await Future.delayed(Duration(milliseconds: 4500));

    // Step 3: Slide down back
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRect(
        child: SlideTransition(
          position: _slideAnim,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  widget.text.toString(),
                  style: GoogleFonts.getFont(
                    designcontroller.valueFontFamily,
                    fontWeight: widget.fontWeight,
                    color: widget.color,
                    fontSize: widget.fontSize,
                    backgroundColor: widget.isFirst
                        ? designcontroller.valueContainerLeft
                        : designcontroller.valueContainerRight,
                    shadows: [
                      Shadow(
                        color: designcontroller.shadowColor.withAlpha(
                          (255 * (designcontroller.textShadowOpacity / 10))
                              .toInt(),
                        ),
                        offset: Offset.zero,
                        blurRadius: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
