import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
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
  late Animation<double> _fadeAnim;
  Design15Controller designcontroller = Get.put(Design15Controller());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700), // slightly longer = smoother feel
    );

    _slideAnim = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Fade synced with the slide so it doesn't just "pop" in/out
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn, // fade in during the first part of the forward anim
      reverseCurve: Curves.easeOut,
    );

    _startAnimationFlow();
  }

  Future<void> _startAnimationFlow() async {
    Timer(Duration(seconds: widget.isFirst ? 1 : 2), () async {
      await _controller.forward();
    });

    await Future.delayed(Duration(milliseconds: 4500));

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
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: const [0.0, 0.15, 0.85, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ClipRect(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
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
                        ),
                      ],
                    ),
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
