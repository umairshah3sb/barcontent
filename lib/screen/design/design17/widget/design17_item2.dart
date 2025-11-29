import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/screen/design/design17/controller/design17_controller.dart';
import 'package:barcontent/screen/design/design17/widget/reveal17_animation.dart';
import 'package:barcontent/util/helper.dart';

class Design17Item2 extends StatefulWidget {
  Map<String, dynamic> data;
  bool isAnimate;
  int index;
  Design17Item2({
    Key? key,
    required this.data,
    this.isAnimate = false,
    this.index = 0,
  }) : super(key: key);

  @override
  State<Design17Item2> createState() => _Design17Item2State();
}

class _Design17Item2State extends State<Design17Item2> {
  final math.Random random = math.Random();

  Design17Controller designController = Get.put(Design17Controller());
  @override
  Widget build(BuildContext context) {
    return Design17Animated(
      isAnimate: designController.isAnimate &&
          designController.currentIndex == widget.index,
      key: Key(getRandomString(20)),
      child: Container(
        key: Key(getRandomString(20)),
        margin: EdgeInsets.symmetric(
          horizontal: designController.itemMarginH,
          vertical: designController.itemMarginV,
        ),
        decoration: BoxDecoration(
          boxShadow: shadow,
          color: designController.itemBackGroundColor,
          borderRadius: borderRadius(designController.itemBorderRadius),
        ),
        child: ClipRRect(
          borderRadius: borderRadius(designController.itemBorderRadius),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: designController.itemsWidth,
                    height: designController.diamondContainerHeight,
                    decoration: BoxDecoration(
                      color: designController.bottomContainerColor,
                    ),
                    child: Center(
                      child: Container(
                          width: designController.diamondWidth,
                          height: designController.diamondHeight,
                          decoration: BoxDecoration(
                            borderRadius:
                                borderRadius(designController.diamondRadius),
                            border: Border.all(
                              width: designController.diamondBorder,
                              color: designController.diamondBorderColor,
                            ),
                            boxShadow: designController.picShadow,
                          ),
                          child: Container(
                            width: 200,
                            height: 200,
                            child: HexagonQuestionMark(
                              data: widget.data,
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                    child: designController.hideIndex
                        ? gap()
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: designController.indexContainerColor,
                              borderRadius: borderRadius(50),
                              boxShadow: shadow,
                            ),
                            child: Center(
                              child: Text(
                                '${widget.data['index']}',
                                style: GoogleFonts.manrope(
                                  color: designController.indexFontColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              ),
              SizedBox(
                height: designController.enableTagline
                    ? designController.spaceBetween.toDouble()
                    : 0,
              ),
              designController.enableTagline
                  ? Container(
                      width: designController.itemsWidth,
                      height: designController.taglineContainerHeight,
                      padding: spacing(h: 10),
                      decoration: BoxDecoration(
                        boxShadow: shadow,
                        color: designController.taglineTextContainer,
                        gradient: designController.taglineGradient
                            ? LinearGradient(
                                colors: [
                                  designController.taglineTextContainer
                                      .withAlpha(100),
                                  designController.taglineTextContainer
                                      .withAlpha(200),
                                  designController.taglineTextContainer,
                                  designController.taglineTextContainer
                                      .withAlpha(200),
                                  designController.taglineTextContainer
                                      .withAlpha(100),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : null,
                      ),
                      child: Center(
                        child: AutoSizeText(
                          widget.data['tagline'].toString(),
                          textAlign: designController.tagTextAlign,
                          style: GoogleFonts.getFont(
                            designController.taglineFontFamily,
                            color: designController.taglineFontColor,
                            fontSize: designController.taglineStyle.fontSize,
                            fontWeight:
                                designController.taglineStyle.fontWeight,
                            wordSpacing:
                                designController.taglineStyle.wordSpacing,
                            decoration:
                                designController.taglineStyle.decoration,
                            height: designController.taglineStyle.height,
                            backgroundColor:
                                designController.taglineStyle.backgroundColor,
                            letterSpacing:
                                designController.taglineStyle.letterSpacing,
                          ),
                        ),
                      ),
                    )
                  : gap(),
              SizedBox(
                height: (designController.itemMarginH * 2),
              ),
              Container(
                width: designController.itemsWidth,
                height: designController.nameContainerHeight,
                padding: spacing(h: 10),
                decoration: BoxDecoration(
                  boxShadow: shadow,
                  color: designController.nameContainerColor,
                  gradient: designController.nameGradient
                      ? LinearGradient(
                          colors: [
                            designController.nameContainerColor.withAlpha(100),
                            designController.nameContainerColor.withAlpha(150),
                            designController.nameContainerColor,
                            designController.nameContainerColor.withAlpha(150),
                            designController.nameContainerColor.withAlpha(100),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                ),
                child: Center(
                  child: AutoSizeText(
                    widget.data['name'].toString(),
                    textAlign: designController.nameTextAlign,
                    style: GoogleFonts.getFont(
                      designController.nameFontFamily,
                      color: designController.nameFontColor,
                      fontSize: designController.nameStyle.fontSize,
                      fontWeight: designController.nameStyle.fontWeight,
                      wordSpacing: designController.nameStyle.wordSpacing,
                      decoration: designController.nameStyle.decoration,
                      height: designController.nameStyle.height,
                      backgroundColor:
                          designController.nameStyle.backgroundColor,
                      letterSpacing: designController.nameStyle.letterSpacing,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: designController.spaceBetween.toDouble(),
              ),
              Expanded(
                child: Container(
                  width: designController.itemsWidth,
                  height: designController.pic1ContainerHeight,
                  decoration: BoxDecoration(
                    color: getColorForIndex(widget.index),
                    gradient: designController.enableRandomColor
                        ? colorPalettes[random.nextInt(colorPalettes.length)]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: designController.pic1Width,
                    height: designController.pic1Height,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius(designController.pic1Radius),
                      border: Border.all(
                        width: designController.pic1Border,
                        color: designController.pic1BorderColor,
                      ),
                      boxShadow: designController.picShadow,
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadius(designController.pic1Radius),
                      child: CachedNetworkImage(
                        key: Key(getRandomString(20)),
                        imageUrl: widget.data['pic'],
                        fit: BoxFit.cover,
                        errorWidget: (c, url, obj) {
                          return Image.network(
                            widget.data['pic'],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HexagonQuestionMark extends StatefulWidget {
  Map<String, dynamic> data;
  HexagonQuestionMark({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<HexagonQuestionMark> createState() => _HexagonQuestionMarkState();
}

class _HexagonQuestionMarkState extends State<HexagonQuestionMark> {
  Design17Controller designController = Get.put(Design17Controller());

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(400, 400),
      painter: HexagonPainter(),
      child: Center(
        child: designController.diamondPic
            ? Container(
                width: designController.iconSize,
                margin: spaceOnly(
                  bottom: designController.iconSpace,
                  left: designController.iconSpace,
                  right: designController.iconSpace,
                ),
                decoration: BoxDecoration(
                  borderRadius: borderRadius(designController.iconRadius),
                  boxShadow: designController.iconShadow,
                ),
                child: CachedNetworkImage(
                  key: Key(getRandomString(20)),
                  imageUrl: widget.data['icon'],
                  fit: BoxFit.cover,
                  errorWidget: (c, url, obj) {
                    return widget.data['icon'].toString().contains('.svg')
                        ? SvgPicture.network(
                            widget.data['icon'],
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.data['icon'],
                            fit: BoxFit.cover,
                          );
                  },
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.data['largeText'].toString()} ',
                    style: GoogleFonts.getFont(
                      designController.largeFontFamily,
                      color: designController.largeFontColor,
                      fontSize: designController.largeStyle.fontSize,
                      fontWeight: designController.largeStyle.fontWeight,
                      wordSpacing: designController.largeStyle.wordSpacing,
                      decoration: designController.largeStyle.decoration,
                      height: designController.largeStyle.height,
                      backgroundColor:
                          designController.largeStyle.backgroundColor,
                      letterSpacing: designController.largeStyle.letterSpacing,
                    ),
                  ),
                  Text(
                    '${widget.data['smallText']}',
                    style: GoogleFonts.getFont(
                      designController.smallFontFamily,
                      color: designController.smallFontColor,
                      fontSize: designController.smallStyle.fontSize,
                      fontWeight: designController.smallStyle.fontWeight,
                      wordSpacing: designController.smallStyle.wordSpacing,
                      decoration: designController.smallStyle.decoration,
                      height: designController.smallStyle.height,
                      backgroundColor:
                          designController.smallStyle.backgroundColor,
                      letterSpacing: designController.smallStyle.letterSpacing,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width / 2;
    final double h = size.height / 2;
    final double r = math.min(w, h);

    // Create a hexagon path
    Path createHexagon(double offsetY) {
      final path = Path();
      for (int i = 0; i < 6; i++) {
        double angle = (math.pi / 3 * i) - math.pi / 2;
        double x = w + r * math.cos(angle);
        double y = h + r * math.sin(angle) + offsetY;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      return path;
    }

    // Draw bottom shadow (darker red, shifted down slightly)
    final shadowPaint = Paint()
      ..color = diamondColorWithShade
      ..style = PaintingStyle.fill;
    canvas.drawPath(createHexagon(8), shadowPaint);

    // Draw main hexagon
    final paint = Paint()
      ..color = diamondColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(createHexagon(0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
