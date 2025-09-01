import 'package:barcontent/screen/design/design16/controller/design16_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class NameSlider extends StatefulWidget {
  String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  NameSlider({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);
  @override
  _NameSliderState createState() => _NameSliderState();
}

class _NameSliderState extends State<NameSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  Design16Controller designcontroller = Get.put(Design16Controller());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6), // total timeline (not critical here)
    );

    _slideAnim = Tween<Offset>(
      begin: Offset(0, -1), // start above container
      end: Offset(0, 3), // end below container
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _startStepAnimation();
  }

  Future<void> _startStepAnimation() async {
    // Move in 4 equal steps
    for (int i = 1; i <= 4; i++) {
      await _controller.animateTo(i * 0.25,
          duration: Duration(milliseconds: 600)); // smooth slide step
      await Future.delayed(Duration(seconds: 4)); // pause 4s at each stop
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ((4 * designcontroller.picContainerWidth) -
            designcontroller.picHMargin),
        child: ClipRect(
          child: SlideTransition(
            position: _slideAnim,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    widget.text.toString(),
                    style: GoogleFonts.getFont(
                      designcontroller.nameFontFamily,
                      fontWeight: widget.fontWeight,
                      color: widget.color,
                      fontSize: widget.fontSize,
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
      ),
    );
  }
}
