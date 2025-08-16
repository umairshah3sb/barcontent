import 'dart:async';

import 'package:barcontent/screen/design/design5/controller/design5_controller.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/helper.dart';
import 'package:typewritertext/typewritertext.dart';

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
  TypeWriterController? tcontroller;
  TypeWriterController? t2controller;
  AnimateDesign() {
    Timer(Duration(seconds: widget.sec), () {
      tcontroller = TypeWriterController(
        text: widget.data['value1'].toString(),
        duration: const Duration(milliseconds: 100),
      );
      setState(() {});

      Timer(Duration(seconds: 1), () {
        t2controller = TypeWriterController(
          text: widget.data['value2'].toString(),
          duration: const Duration(milliseconds: 100),
        );
        setState(() {});
      });
    });
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
                            tcontroller != null
                                ? Container(
                                    width: controller.valueWidth,
                                    height: controller.dataContainerHeight,
                                    alignment: Alignment.centerRight,
                                    child: FittedBox(
                                      child: TypeWriter(
                                          controller:
                                              tcontroller, // valueController // streamController
                                          builder: (context, value) {
                                            return Text(
                                              value.text,
                                              style: GoogleFonts.manrope(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    controller.valueFontColor,
                                                fontSize:
                                                    controller.valueFontSize,
                                              ),
                                              maxLines: 2,
                                            );
                                          }),
                                    ),
                                  )
                                : gap(),
                            t2controller != null
                                ? Container(
                                    width: controller.valueWidth,
                                    height: controller.dataContainerHeight,
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      child: TypeWriter(
                                          controller:
                                              t2controller, // valueController // streamController
                                          builder: (context, value) {
                                            return Text(
                                              value.text,
                                              style: GoogleFonts.manrope(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    controller.valueFontColor,
                                                fontSize:
                                                    controller.valueFontSize,
                                              ),
                                              maxLines: 2,
                                            );
                                          }),
                                    ),
                                  )
                                : gap(),
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
                    borderRadius: borderRadius(controller.picContainerRadius),
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
                        color: controller.picIconColor,
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
