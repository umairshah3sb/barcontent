import 'dart:async';
import 'package:barcontent/screen/design/design16/controller/design16_controller.dart';
import 'package:barcontent/screen/design/design16/widgets/Icon_slider.dart';
import 'package:barcontent/screen/design/design16/widgets/name_slider.dart';
import 'package:barcontent/screen/design/design16/widgets/slider_Image.dart';
import 'package:barcontent/screen/design/design16/widgets/text_slider.dart';
import 'package:barcontent/util/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design16Item extends StatefulWidget {
  int sec;
  bool isFirst;
  Map<String, dynamic> itemData;
  Design16Item({
    Key? key,
    required this.sec,
    this.isFirst = true,
    required this.itemData,
  }) : super(key: key);

  @override
  State<Design16Item> createState() => _Design16ItemState();
}

class _Design16ItemState extends State<Design16Item>
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
    return GetBuilder<Design16Controller>(builder: (controller) {
      return Column(
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
          gap(h: controller.deviceMarginTop),
          Stack(
            children: [
              Container(
                width: (controller.picContainerWidth),
                height: (controller.picContainerHeight),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: (controller.picContainerWidth),
                  height: (controller.picContainerHeight),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: borderRadius(controller.logoRadius),
                    border: Border.all(
                        color: controller.flagBorderColor,
                        width: controller.flagBorderSize),
                    boxShadow: [
                      BoxShadow(
                        color: controller.flagShadowColor.withAlpha(
                          (255 * (controller.flagShadowOpacity / 10)).toInt(),
                        ),
                        blurRadius: 28.68,
                        offset: Offset(0, 28.68),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: controller.flagShadowColor.withAlpha(
                          (255 * (controller.flagShadowOpacity / 10)).toInt(),
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
                              : 'https://i.postimg.cc/52q3kLvd/image.png'
                          : controller.logo2.text.isNotEmpty
                              ? controller.logo2.text
                              : 'https://i.postimg.cc/hGt9ywcT/image.png',
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
                    height: ((controller.picContainerWidth) -
                        controller.picVMargin),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius(controller.picContainerRadius),
                      border: Border.all(
                          color: controller.picBorderColor,
                          width: controller.picBorderSize),
                    ),
                    child: SlideInSteps(
                      key: Key(getRandomString(20)),
                      pic: controller.csvData.isNotEmpty
                          ? widget.isFirst
                              ? widget.itemData['icon']
                              : widget.itemData['icon']
                          : 'https://i.postimg.cc/50zH9Pw6/image.png',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: controller.correctIconBottom,
                child: widget.itemData['flag1'].toString() == '2'
                    ? gap()
                    : Center(
                        child: Container(
                          width: controller.correctIconSize,
                          height: controller.correctIconSize,
                          decoration: BoxDecoration(
                            borderRadius:
                                borderRadius(controller.picContainerRadius),
                            border: Border.all(
                                color: controller.picBorderColor,
                                width: controller.picBorderSize),
                          ),
                          child: SlideUpPauseDownIcon(
                            key: Key(getRandomString(20)),
                            delay: 3,
                            duration: 1,
                            url: controller.csvData.isEmpty
                                ? widget.isFirst
                                    ? 'https://i.postimg.cc/sD7R4R2x/image.png'
                                    : 'https://i.postimg.cc/RVcjnQPn/image.png'
                                : widget.isFirst
                                    ? widget.itemData['flag1'].toString() == '1'
                                        ? 'https://i.postimg.cc/sD7R4R2x/image.png'
                                        : 'https://i.postimg.cc/RVcjnQPn/image.png'
                                    : widget.itemData['flag2'].toString() == '1'
                                        ? 'https://i.postimg.cc/sD7R4R2x/image.png'
                                        : 'https://i.postimg.cc/RVcjnQPn/image.png',
                          ),
                        ),
                      ),
              ),
            ],
          ),
          gap(h: controller.deviceMarginBottom),
          Column(
            children: [
              NameSlider(
                key: Key(getRandomString(20)),
                text: controller.csvData.isNotEmpty
                    ? widget.itemData['subtitle'].toString()
                    : 'Price',
                fontSize: controller.nameTextSize,
                fontWeight: FontWeight.w100,
                color: controller.nameFontColor,
              ),
              gap(h: 10),
              widget.isFirst
                  ? SlideUpPauseDown(
                      key: Key(getRandomString(20)),
                      isFirst: true,
                      text: widget.itemData['value1'],
                      fontSize: controller.valueFontSize,
                      fontWeight: FontWeight.bold,
                      color: controller.valueFontColor,
                    )
                  : SlideUpPauseDown(
                      key: Key(getRandomString(20)),
                      isFirst: false,
                      text: widget.itemData['value2'],
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

class Design16MainUI extends StatefulWidget {
  Map<String, dynamic> itemData;
  Design16MainUI({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  @override
  State<Design16MainUI> createState() => _Design16MainUIState();
}

class _Design16MainUIState extends State<Design16MainUI> {
  final Design16Controller designController = Get.put(Design16Controller());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Design16Item(
            sec: 1,
            itemData: widget.itemData,
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: Get.height * 0.7,
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
                          (255 * (designController.textShadowOpacity / 10))
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
          child: Design16Item(
            sec: 1,
            itemData: widget.itemData,
            isFirst: false,
          ),
        ),
      ],
    );
  }
}
