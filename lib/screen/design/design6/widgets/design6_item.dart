import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typewritertext/typewritertext.dart';

import 'package:barcontent/screen/design/Design6/controller/Design6_controller.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design6Item extends StatefulWidget {
  int sec;
  bool isFirst;
  Design6Item({
    Key? key,
    required this.sec,
    this.isFirst = true,
  }) : super(key: key);

  @override
  State<Design6Item> createState() => _Design6ItemState();
}

class _Design6ItemState extends State<Design6Item>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  TypeWriterController? tcontroller;
  TypeWriterController? t2controller;
  AnimateDesign() {
    final Design6Controller designController = Get.put(Design6Controller());

    Timer(Duration(seconds: widget.sec), () {
      tcontroller = TypeWriterController(
        text: designController.currentItems.isEmpty
            ? "1500"
            : widget.isFirst
                ? designController.currentItems['value1'].toString()
                : designController.currentItems['value2'].toString(),
        duration: const Duration(milliseconds: 100),
      );
      setState(() {});
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
    return GetBuilder<Design6Controller>(builder: (controller) {
      return Column(
        children: [
          Text(
            widget.isFirst
                ? controller.name1.text.toString()
                : controller.name2.text.toString(),
            style: GoogleFonts.manrope(
              fontSize: controller.countryNameFontSize,
              fontWeight: FontWeight.w800,
              color: controller.countryNameFontColor,
            ),
            textAlign: TextAlign.center,
          ),
          Stack(
            children: [
              Container(
                width: 400,
                height: 300,
                margin: spacing(h: 10, v: 10),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: borderRadius(controller.logoRadius),
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
                  borderRadius: borderRadius(controller.logoRadius),
                  child: CachedNetworkImage(
                    imageUrl: widget.isFirst
                        ? controller.logo1.text.isNotEmpty
                            ? controller.logo1.text
                            : 'https://upload.wikimedia.org/wikipedia/commons/3/32/Flag_of_Pakistan.svg'
                        : controller.logo2.text.isNotEmpty
                            ? controller.logo2.text
                            : 'https://upload.wikimedia.org/wikipedia/commons/3/32/Flag_of_Pakistan.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Center(
                  child: Container(
                    width: 320,
                    height: 250,
                    margin: spacing(h: 10, v: 10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: borderRadius(controller.logoRadius),
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
                      borderRadius: borderRadius(controller.logoRadius),
                      child: CachedNetworkImage(
                        imageUrl: controller.currentItems.isNotEmpty
                            ? widget.isFirst
                                ? controller.currentItems['pic']
                                : controller.currentItems['pic']
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4YUGZxyDSsiMSLCv5rk3Fj2m3P3xGNwXPID2ec91RzMIHU2gOYq1-UVkM0pP6vjQ1e10&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          gap(h: 30),
          Column(
            children: [
              Text(
                controller.currentItems.isNotEmpty
                    ? controller.currentItems['name'].toString()
                    : 'Tanks',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  color: controller.nameFontColor,
                  fontSize: controller.nameTextSize,
                ),
              ),
              gap(h: 10),
              tcontroller != null
                  ? TypeWriter(
                      controller:
                          tcontroller, // valueController // streamController
                      builder: (context, value) {
                        return Text(
                          value.text,
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            color: controller.valueFontColor,
                            fontSize: controller.valueFontSize,
                          ),
                        );
                      })
                  : gap(),
            ],
          )
        ],
      );
    });
  }
}
