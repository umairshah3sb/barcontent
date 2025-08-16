import 'dart:async';


import 'package:barcontent/screen/design/design11/controller/design11_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design11Item extends StatefulWidget {
  int sec;
  bool isFirst;
  Map<String, dynamic> itemData;
  Design11Item({
    Key? key,
    required this.sec,
    this.isFirst = true,
    required this.itemData,
  }) : super(key: key);

  @override
  State<Design11Item> createState() => _Design11ItemState();
}

class _Design11ItemState extends State<Design11Item>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _scaleAnimation;
  TypeWriterController? tcontroller;
  TypeWriterController? t2controller;
  AnimateDesign() {
    Timer(Duration(seconds: widget.isFirst ? 0 : 1), () {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      );

      _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );

      // Start animation after a short delay
      Future.delayed(Duration(seconds: 1), () {
        _controller.forward();
      });
      setState(() {});
    });
    Timer(Duration(seconds: widget.isFirst ? 3 : 4), () {
      tcontroller = TypeWriterController(
        text: widget.itemData['value1'].toString(),
        duration: const Duration(milliseconds: 50),
      );
      setState(() {});

      Timer(Duration(seconds: 1), () {
        t2controller = TypeWriterController(
          text: widget.itemData['value2'].toString(),
          duration: const Duration(milliseconds: 50),
        );
        setState(() {});
      });
    });
    // Start the animation
  }

  @override
  void initState() {
    AnimateDesign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design11Controller>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.isFirst
                ? controller.name1.text.toString()
                : controller.name2.text.toString(),
            style: GoogleFonts.manrope(
              fontSize: controller.countryNameFontSize,
              fontWeight: FontWeight.w800,
              color: controller.countryNameFontColor,
              shadows: [
                Shadow(
                  color: controller.shadowColor.withAlpha(
                    (255 * (controller.textShadowOpacity / 10)).toInt(),
                  ),
                  offset: Offset.zero,
                  blurRadius: 10,
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Stack(
            children: [
              Container(
                width: (4 * controller.picContainerSize),
                height: (3 * controller.picContainerSize),
                margin: spacing(h: 10, v: 10),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: Center(
                  child: _scaleAnimation != null
                      ? ScaleTransition(
                          alignment: Alignment.bottomCenter,
                          scale: _scaleAnimation!,
                          child: Container(
                            width: (4 * controller.picContainerSize),
                            height: (3 * controller.picContainerSize),
                            margin: spacing(h: 10, v: 10),
                            decoration: BoxDecoration(
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
                                key: Key(getRandomString(20)),
                                imageUrl: controller.csvData.isNotEmpty
                                    ? widget.isFirst
                                        ? widget.itemData['pic1']
                                        : widget.itemData['pic2']
                                    : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4YUGZxyDSsiMSLCv5rk3Fj2m3P3xGNwXPID2ec91RzMIHU2gOYq1-UVkM0pP6vjQ1e10&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : gap(),
                ),
              ),
              widget.isFirst
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: controller.countryFlagSize,
                        height: (controller.countryFlagSize * 0.75),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
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
                          borderRadius: borderRadius(
                            controller.logoRadius,
                          ),
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
                    )
                  : Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: controller.countryFlagSize,
                        height: (controller.countryFlagSize * 0.75),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
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
                    )
            ],
          ),
          gap(h: 30),
          Column(
            children: [
              Text(
                controller.csvData.isNotEmpty
                    ? widget.itemData['name'].toString()
                    : 'Tanks',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  color: controller.nameFontColor,
                  fontSize: controller.nameTextSize,
                  shadows: [
                    Shadow(
                      color: controller.shadowColor.withAlpha(
                        (255 * (controller.textShadowOpacity / 10)).toInt(),
                      ),
                      offset: Offset.zero,
                      blurRadius: 10,
                    )
                  ],
                ),
              ),
              gap(h: 10),
              widget.isFirst
                  ? tcontroller != null
                      ? Container(
                          width: Get.width * 4,
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: TypeWriter(
                                controller:
                                    tcontroller, // valueController // streamController
                                builder: (context, value) {
                                  return Text(
                                    value.text,
                                    style: GoogleFonts.alfaSlabOne(
                                      fontWeight: FontWeight.bold,
                                      color: controller.valueFontColor,
                                      fontSize: controller.valueFontSize,
                                      shadows: [
                                        Shadow(
                                          color:
                                              controller.shadowColor.withAlpha(
                                            (255 *
                                                    (controller
                                                            .textShadowOpacity /
                                                        10))
                                                .toInt(),
                                          ),
                                          offset: Offset.zero,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      : gap()
                  : t2controller != null
                      ? Container(
                          width: Get.width * 4,
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: TypeWriter(
                                controller:
                                    t2controller, // valueController // streamController
                                builder: (context, value) {
                                  return Text(
                                    value.text,
                                    style: GoogleFonts.alfaSlabOne(
                                      fontWeight: FontWeight.bold,
                                      color: controller.valueFontColor,
                                      fontSize: controller.valueFontSize,
                                      shadows: [
                                        Shadow(
                                          color:
                                              controller.shadowColor.withAlpha(
                                            (255 *
                                                    (controller
                                                            .textShadowOpacity /
                                                        10))
                                                .toInt(),
                                          ),
                                          offset: Offset.zero,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      : gap(),
            ],
          )
        ],
      );
    });
  }
}

class Design11MainUI extends StatefulWidget {
  Map<String, dynamic> itemData;
  Design11MainUI({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  @override
  State<Design11MainUI> createState() => _Design11MainUIState();
}

class _Design11MainUIState extends State<Design11MainUI> {
  final Design11Controller designController = Get.put(Design11Controller());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Design11Item(
            sec: 1,
            itemData: widget.itemData,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: Get.height * 0.7,
          child: Text(
            'VS',
            style: GoogleFonts.alfaSlabOne(
              fontSize: designController.countryNameFontSize,
              fontWeight: FontWeight.w800,
              color: designController.countryNameFontColor,
              shadows: [
                Shadow(
                  color: designController.shadowColor.withAlpha(
                    (255 * (designController.textShadowOpacity / 10)).toInt(),
                  ),
                  offset: Offset.zero,
                  blurRadius: 10,
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Design11Item(
            sec: 1,
            itemData: widget.itemData,
            isFirst: false,
          ),
        ),
      ],
    );
  }
}
