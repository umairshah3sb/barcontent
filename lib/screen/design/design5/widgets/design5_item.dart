import 'dart:async';
import 'dart:math';

import 'package:barcontent/screen/design/design3/controller/design3_controller.dart';
import 'package:barcontent/screen/design/design4/controller/design4_controller.dart';
import 'package:barcontent/screen/design/design5/controller/design5_controller.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/helper.dart';

class Design5Item extends StatefulWidget {
  int sec;
  Map<String, dynamic> data;
  Design5Item({
    Key? key,
    required this.sec,
    required this.data,
  }) : super(key: key);

  @override
  State<Design5Item> createState() => _Design5ItemState();
}

class _Design5ItemState extends State<Design5Item>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  AnimateDesign() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.sec),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(); // Start the animation
  }

  @override
  void initState() {
    AnimateDesign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design5Controller>(builder: (controller) {
      return Container(
        width: controller.dataContainerWidth,
        margin: spacing(v: controller.dataContainerSpacing),
        child: Stack(
          children: [
            SizedBox(
              height: controller.valueContainerSize,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: controller.dataContainerHeight,
                      width: double.infinity,
                      padding: spacing(h: 20),
                    ),
                    Positioned(
                      child: Container(
                        height: controller.dataContainerHeight,
                        width: double.infinity,
                        padding: spacing(h: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: Text(
                                widget.data['value1'].toString(),
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  color: controller.valueFontColor,
                                  fontSize: controller.valueFontSize,
                                ),
                              ),
                            ),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: Text(
                                widget.data['value2'].toString(),
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  color: controller.valueFontColor,
                                  fontSize: controller.valueFontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                child: Container(
                  width: controller.picContainerSize,
                  height: controller.picContainerSize,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: borderRadius(100),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26442A7C),
                        blurRadius: 28.68,
                        offset: Offset(0, 28.68),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x26442A7C),
                        blurRadius: 28.68,
                        offset: Offset(0, 28.68),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius(
                      controller.picContainerRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.data['pic'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
