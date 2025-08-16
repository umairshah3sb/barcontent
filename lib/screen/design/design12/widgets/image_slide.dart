import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:barcontent/util/helper.dart';

class SlideImageFromBottom extends StatefulWidget {
  String img;
  int seconds;
  SlideImageFromBottom({
    Key? key,
    required this.img,
    required this.seconds,
  }) : super(key: key);
  @override
  _SlideImageFromBottomState createState() => _SlideImageFromBottomState();
}

class _SlideImageFromBottomState extends State<SlideImageFromBottom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    isAvailable = false;
    Timer(Duration(seconds: widget.seconds), () {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
      );
      _offsetAnimation = Tween<Offset>(
        begin: Offset(0.0, 1.0), // Start from bottom
        end: Offset.zero, // End at normal position
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
      isAvailable = true;
      setState(() {});
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isAvailable
        ? Center(
            child: SlideTransition(
              position: _offsetAnimation,
              child: CachedNetworkImage(
                key: Key(getRandomString(20)),
                imageUrl: widget.img,
                fit: BoxFit.cover,
              ),
            ),
          )
        : gap();
  }
}
