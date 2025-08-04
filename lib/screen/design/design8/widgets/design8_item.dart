
import 'package:barcontent/screen/design/design8/controller/design8_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:barcontent/util/helper.dart';
import 'package:google_fonts/google_fonts.dart';

class Design8Item extends StatefulWidget {
  Map<String, dynamic> data;
  Design8Item({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<Design8Item> createState() => _Design8ItemState();
}

class _Design8ItemState extends State<Design8Item> {
  Design8Controller designController = Get.put(Design8Controller());

  bool animate = false;
  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = (Get.height - 300);
    double containerHeight =
        maxHeight * (double.parse(widget.data['percentage'].toString()));
    return Stack(
      children: [
        Container(
          margin: spacing(h: 8),
          width: designController.valueContainerSize,
          height: Get.height,
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 2),
          curve: Curves.easeOut,
          bottom: 10,
          height: animate ? (containerHeight + 250) : 40,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            child: Container(
              height: (containerHeight + 250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: Center(
                        child: Text(
                          '${widget.data['value']} ${widget.data['prefix']}',
                          style: GoogleFonts.alfaSlabOne(
                            fontWeight: FontWeight.bold,
                            color: designController.valueFontColor,
                            fontSize: designController.valueFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  gap(h: 10),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: designController.valueContainerSize,
                      margin: spacing(h: 8),
                      padding: spaceOnly(top: 10),
                      decoration: BoxDecoration(
                        color: getRandomDarkColor(),
                        boxShadow: shadow,
                        borderRadius: radiusOnly(
                          topLeft: 50,
                          topRight: 50,
                        ),
                      ),
                      child: Container(
                        width: designController.picContainerSize,
                        height: designController.picContainerSize,
                        decoration: BoxDecoration(
                          boxShadow: shadow,
                          borderRadius: borderRadius(50),
                        ),
                        child: CircleAvatar(
                          radius: (designController.picContainerSize / 2),
                          backgroundColor: Colors.orange,
                          foregroundImage: NetworkImage(
                            widget.data['pic'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  gap(h: 10),
                  Container(
                    height: 80,
                    padding: spacing(v: 10),
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: Center(
                        child: Text(
                          widget.data['name'],
                          style: GoogleFonts.alfaSlabOne(
                            fontWeight: FontWeight.bold,
                            color: designController.nameFontColor,
                            fontSize: designController.nameTextSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
