import 'dart:async';

import 'package:barcontent/screen/design/design15/controller/design15_controller.dart';
import 'package:barcontent/screen/design/design15/widgets/name_slider.dart';
import 'package:barcontent/screen/design/design15/widgets/slider_Image.dart';
import 'package:barcontent/screen/design/design15/widgets/text_slider.dart';
import 'package:barcontent/util/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design15Item extends StatefulWidget {
  int sec;
  bool isFirst;
  Map<String, dynamic> itemData;
  Design15Item({
    Key? key,
    required this.sec,
    this.isFirst = true,
    required this.itemData,
  }) : super(key: key);

  @override
  State<Design15Item> createState() => _Design15ItemState();
}

class _Design15ItemState extends State<Design15Item>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    animateData();
  }

  animateData() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // total duration
    );

    // First stop position: half way down (0.5)
    _animation = Tween<Offset>(
      begin: Offset(0, -1), // Start above screen
      end: Offset(0, 1), // End fully below screen
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Step 1: Move halfway
    _controller.animateTo(0.3, duration: Duration(seconds: 1)).then((_) async {
      // Step 2: Wait 3 seconds
      await Future.delayed(Duration(seconds: 3));

      // Step 3: Continue to the end
      _controller.animateTo(1.0, duration: Duration(seconds: 2));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design15Controller>(builder: (controller) {
      return controller.changeStyle
          ? Container(
              padding: spacing(h: controller.VideoContainerSpacingH),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isFirst
                        ? controller.name1.text.toString()
                        : controller.name2.text.toString(),
                    style: GoogleFonts.getFont(
                      controller.countryFontFamily,
                      fontSize: controller.countryNameFontSize,
                      fontWeight: FontWeight.bold,
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
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: (controller.picContainerWidth),
                            height: (controller.picContainerHeight),
                          ),
                          widget.isFirst
                              ? Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: (controller.picContainerWidth),
                                    height: (controller.picContainerHeight),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          borderRadius(controller.logoRadius),
                                      border: Border.all(
                                          color: controller.flagBorderColor,
                                          width: controller.flagBorderSize),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.flagShadowColor
                                              .withAlpha(
                                            (255 *
                                                    (controller
                                                            .flagShadowOpacity /
                                                        10))
                                                .toInt(),
                                          ),
                                          blurRadius: 28.68,
                                          offset: Offset(0, 28.68),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: controller.flagShadowColor
                                              .withAlpha(
                                            (255 *
                                                    (controller
                                                            .flagShadowOpacity /
                                                        10))
                                                .toInt(),
                                          ),
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
                                    width: (controller.picContainerWidth),
                                    height: (controller.picContainerHeight),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          borderRadius(controller.logoRadius),
                                      border: Border.all(
                                          color: controller.flagBorderColor,
                                          width: controller.flagBorderSize),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.flagShadowColor
                                              .withAlpha(
                                            (255 *
                                                    (controller
                                                            .flagShadowOpacity /
                                                        10))
                                                .toInt(),
                                          ),
                                          blurRadius: 28.68,
                                          offset: Offset(0, 28.68),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: controller.flagShadowColor
                                              .withAlpha(
                                            (255 *
                                                    (controller
                                                            .flagShadowOpacity /
                                                        10))
                                                .toInt(),
                                          ),
                                          blurRadius: 28.68,
                                          offset: Offset(0, 28.68),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          borderRadius(controller.logoRadius),
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
                                ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: Center(
                              child: Container(
                                width: ((controller.picContainerWidth) -
                                    controller.picHMargin),
                                height: ((controller.picContainerHeight) -
                                    controller.picVMargin),
                                decoration: BoxDecoration(
                                  borderRadius: borderRadius(
                                      controller.picContainerRadius),
                                  border: Border.all(
                                      color: controller.picBorderColor,
                                      width: controller.picBorderSize),
                                ),
                                child: SlideInSteps(
                                  key: Key(getRandomString(20)),
                                  pic: controller.csvData.isNotEmpty
                                      ? widget.isFirst
                                          ? controller.differencePic
                                              ? widget.itemData['pic1']
                                              : widget.itemData['pic']
                                          : controller.differencePic
                                              ? widget.itemData['pic2']
                                              : widget.itemData['pic']
                                      : widget.itemData['pic'].toString(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      gap(h: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: controller.valueWidth,
                            child: NameSlider(
                              key: Key(getRandomString(20)),
                              text: controller.csvData.isNotEmpty
                                  ? widget.itemData['name'].toString()
                                  : controller.dumyData['name'].toString(),
                              fontSize: controller.nameTextSize,
                              fontWeight: FontWeight.w100,
                              color: controller.nameFontColor,
                            ),
                          ),
                          gap(h: 10),
                          Container(
                            width: controller.valueWidth,
                            child: widget.isFirst
                                ? SlideUpPauseDown(
                                    key: Key(getRandomString(20)),
                                    isFirst: true,
                                    text: widget.itemData['value1'].toString(),
                                    fontSize: controller.valueFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: controller.valueFontColor,
                                  )
                                : SlideUpPauseDown(
                                    key: Key(getRandomString(20)),
                                    isFirst: false,
                                    text: widget.itemData['value2'].toString(),
                                    fontSize: controller.valueFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: controller.valueFontColor,
                                  ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isFirst
                      ? controller.name1.text.toString()
                      : controller.name2.text.toString(),
                  style: GoogleFonts.getFont(
                    controller.countryFontFamily,
                    fontSize: controller.countryNameFontSize,
                    fontWeight: FontWeight.bold,
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
                      width: (controller.picContainerWidth),
                      height: (controller.picContainerHeight),
                    ),
                    widget.isFirst
                        ? Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: (controller.picContainerWidth),
                              height: (controller.picContainerHeight),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    borderRadius(controller.logoRadius),
                                border: Border.all(
                                    color: controller.flagBorderColor,
                                    width: controller.flagBorderSize),
                                boxShadow: [
                                  BoxShadow(
                                    color: controller.flagShadowColor.withAlpha(
                                      (255 *
                                              (controller.flagShadowOpacity /
                                                  10))
                                          .toInt(),
                                    ),
                                    blurRadius: 28.68,
                                    offset: Offset(0, 28.68),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: controller.flagShadowColor.withAlpha(
                                      (255 *
                                              (controller.flagShadowOpacity /
                                                  10))
                                          .toInt(),
                                    ),
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
                              width: (controller.picContainerWidth),
                              height: (controller.picContainerHeight),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    borderRadius(controller.logoRadius),
                                border: Border.all(
                                    color: controller.flagBorderColor,
                                    width: controller.flagBorderSize),
                                boxShadow: [
                                  BoxShadow(
                                    color: controller.flagShadowColor.withAlpha(
                                      (255 *
                                              (controller.flagShadowOpacity /
                                                  10))
                                          .toInt(),
                                    ),
                                    blurRadius: 28.68,
                                    offset: Offset(0, 28.68),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: controller.flagShadowColor.withAlpha(
                                      (255 *
                                              (controller.flagShadowOpacity /
                                                  10))
                                          .toInt(),
                                    ),
                                    blurRadius: 28.68,
                                    offset: Offset(0, 28.68),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    borderRadius(controller.logoRadius),
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
                          ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Center(
                        child: Container(
                          width: ((controller.picContainerWidth) -
                              controller.picHMargin),
                          height: ((controller.picContainerHeight) -
                              controller.picVMargin),
                          decoration: BoxDecoration(
                            borderRadius:
                                borderRadius(controller.picContainerRadius),
                            border: Border.all(
                                color: controller.picBorderColor,
                                width: controller.picBorderSize),
                          ),
                          child: SlideInSteps(
                            key: Key(getRandomString(20)),
                            pic: controller.csvData.isNotEmpty
                                ? widget.isFirst
                                    ? controller.differencePic
                                        ? widget.itemData['pic1']
                                        : widget.itemData['pic']
                                    : controller.differencePic
                                        ? widget.itemData['pic2']
                                        : widget.itemData['pic']
                                : widget.itemData['pic'].toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                gap(h: 30),
                Column(
                  children: [
                    NameSlider(
                      key: Key(getRandomString(20)),
                      text: controller.csvData.isNotEmpty
                          ? widget.itemData['name'].toString()
                          : controller.dumyData['name'].toString(),
                      fontSize: controller.nameTextSize,
                      fontWeight: FontWeight.w100,
                      color: controller.nameFontColor,
                    ),
                    gap(h: 10),
                    widget.isFirst
                        ? SlideUpPauseDown(
                            key: Key(getRandomString(20)),
                            isFirst: true,
                            text: widget.itemData['value1'].toString(),
                            fontSize: controller.valueFontSize,
                            fontWeight: FontWeight.bold,
                            color: controller.valueFontColor,
                          )
                        : SlideUpPauseDown(
                            key: Key(getRandomString(20)),
                            isFirst: false,
                            text: widget.itemData['value2'].toString(),
                            fontSize: controller.valueFontSize,
                            fontWeight: FontWeight.bold,
                            color: controller.valueFontColor,
                          )
                  ],
                )
              ],
            );
    });
  }
}

class Design15MainUI extends StatefulWidget {
  Map<String, dynamic> itemData;
  Design15MainUI({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  @override
  State<Design15MainUI> createState() => _Design15MainUIState();
}

class _Design15MainUIState extends State<Design15MainUI> {
  final Design15Controller designController = Get.put(Design15Controller());
  @override
  Widget build(BuildContext context) {
    return designController.changeStyle
        ? Container(
            height: designController.VideoContainerHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Design15Item(
                    sec: 1,
                    itemData: widget.itemData,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: designController.verserImage.text.isEmpty
                      ? Text(
                          'VS',
                          style: GoogleFonts.alfaSlabOne(
                            fontSize: designController.countryNameFontSize,
                            fontWeight: FontWeight.w800,
                            color: designController.countryNameFontColor,
                            shadows: [
                              Shadow(
                                color: designController.shadowColor.withAlpha(
                                  (255 *
                                          (designController.textShadowOpacity /
                                              10))
                                      .toInt(),
                                ),
                                offset: Offset.zero,
                                blurRadius: 10,
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      : SizedBox(
                          width: designController.vsImageWidth,
                          child: CachedNetworkImage(
                            imageUrl: designController.verserImage.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: Design15Item(
                    sec: 1,
                    itemData: widget.itemData,
                    isFirst: false,
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Design15Item(
                  sec: 1,
                  itemData: widget.itemData,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: designController.picContainerHeight,
                child: designController.verserImage.text.isEmpty
                    ? Center(
                        child: Text(
                          'VS',
                          style: GoogleFonts.alfaSlabOne(
                            fontSize: designController.countryNameFontSize,
                            fontWeight: FontWeight.w800,
                            color: designController.countryNameFontColor,
                            shadows: [
                              Shadow(
                                color: designController.shadowColor.withAlpha(
                                  (255 *
                                          (designController.textShadowOpacity /
                                              10))
                                      .toInt(),
                                ),
                                offset: Offset.zero,
                                blurRadius: 10,
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : SizedBox(
                        width: designController.vsImageWidth,
                        child: CachedNetworkImage(
                          imageUrl: designController.verserImage.text,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Expanded(
                child: Design15Item(
                  sec: 1,
                  itemData: widget.itemData,
                  isFirst: false,
                ),
              ),
            ],
          );
  }
}
