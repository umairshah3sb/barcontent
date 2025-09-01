import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/screen/design/design15/controller/design15_controller.dart';

class SlideUpPauseDownIcon extends StatefulWidget {
  String url;
  int duration;
  int delay;

  SlideUpPauseDownIcon({
    Key? key,
    required this.url,
    required this.duration,
    required this.delay,
  }) : super(key: key);
  @override
  _SlideUpPauseDownIconState createState() => _SlideUpPauseDownIconState();
}

class _SlideUpPauseDownIconState extends State<SlideUpPauseDownIcon>
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
    // Step 1: Wait for the delay
    await Future.delayed(Duration(seconds: widget.delay));

    // Step 2: Slide up
    await _controller.forward();

    // Step 3: Pause at the top
    await Future.delayed(Duration(seconds: widget.duration));

    // Step 4: Slide down
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
              child: CachedNetworkImage(
                imageUrl: widget.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
