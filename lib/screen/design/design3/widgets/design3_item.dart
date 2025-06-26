import 'dart:async';
import 'dart:math';

import 'package:barcontent/screen/design/design3/controller/design3_controller.dart';
import 'package:barcontent/screen/design/design4/controller/design4_controller.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/helper.dart';

class Design3Item extends StatefulWidget {
  int sec;
  Map<String, dynamic> data;
  Design3Item({
    Key? key,
    required this.sec,
    required this.data,
  }) : super(key: key);

  @override
  State<Design3Item> createState() => _Design3ItemState();
}

class _Design3ItemState extends State<Design3Item> {
  bool showData = false;
  AnimateDesign() {
    Timer(Duration(seconds: widget.sec), () {
      showData = true;
      setState(() {});
    });
  }

  @override
  void initState() {
    AnimateDesign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design4Controller>(builder: (controller) {
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
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(15),
                        gradient: LinearGradient(
                          colors: [
                            controller.valueContainerLeft,
                            controller.valueContainerRight
                          ],
                        ),
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
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      width: showData ? 0 : controller.dataContainerWidth,
                      height: controller.dataContainerHeight,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.valueContainerAnimation,
                            borderRadius: borderRadius(15),
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
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: controller.dataContainerHeight,
                        width: double.infinity,
                        padding: spacing(h: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                showData
                                    ? widget.data['value1'].toString()
                                    : "?",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  color: controller.valueFontColor,
                                  fontSize: controller.valueFontSize,
                                ),
                              ),
                            ),
                            Text(
                              showData ? widget.data['value2'].toString() : '?',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                color: controller.valueFontColor,
                                fontSize: controller.valueFontSize,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: (widget.data['pic'] == null ||
                      widget.data['pic'].toString().isEmpty)
                  ? gap()
                  : Center(
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
                          borderRadius:
                              borderRadius(controller.picContainerRadius),
                          child: CachedNetworkImage(
                            imageUrl: widget.data['pic'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.data['name'],
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color: controller.nameFontColor,
                    fontSize: controller.nameTextSize,
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
