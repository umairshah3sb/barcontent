import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcontent/screen/design/design17/controller/design17_controller.dart';
import 'package:barcontent/screen/design/design17/widget/reveal17_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/util/helper.dart';

class Design17Item extends StatefulWidget {
  Map<String, dynamic> data;
  bool isAnimate;
  int index;
  Design17Item({
    Key? key,
    required this.data,
    this.isAnimate = false,
    this.index = 0,
  }) : super(key: key);

  @override
  State<Design17Item> createState() => _Design17ItemState();
}

class _Design17ItemState extends State<Design17Item> {
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
                    height: designController.pic1ContainerHeight,
                    decoration: BoxDecoration(
                      color: designController.enableRandomColor
                          ? getRandomColor()
                          : designController.picBackgroundColor,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          designController.enableRandomColor
                              ? getRandomColor()
                              : designController.picBackgroundColor,
                          designController.enableRandomColor
                              ? getRandomColor()
                              : designController.picBackgroundColor,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: designController.pic1Width,
                        height: designController.pic1Height,
                        decoration: BoxDecoration(
                          borderRadius:
                              borderRadius(designController.pic1Radius),
                          border: Border.all(
                            width: designController.pic1Border,
                            color: designController.pic1BorderColor,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              borderRadius(designController.pic1Radius),
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
                height: designController.spaceBetween.toDouble(),
              ),
              Container(
                width: designController.itemsWidth,
                height: designController.nameContainerHeight,
                padding: spacing(h: 10),
                decoration: BoxDecoration(
                  boxShadow: shadow,
                  gradient: LinearGradient(
                    colors: [
                      designController.nameContainerColor.withAlpha(100),
                      designController.nameContainerColor.withAlpha(200),
                      designController.nameContainerColor,
                      designController.nameContainerColor.withAlpha(200),
                      designController.nameContainerColor.withAlpha(100),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
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
                height: (designController.itemMarginH * 2),
              ),
              Container(
                width: designController.itemsWidth,
                height: designController.taglineContainerHeight,
                padding: spacing(h: 10),
                decoration: BoxDecoration(
                  boxShadow: shadow,
                  gradient: LinearGradient(
                    colors: [
                      designController.taglineTextContainer.withAlpha(100),
                      designController.taglineTextContainer.withAlpha(200),
                      designController.taglineTextContainer,
                      designController.taglineTextContainer.withAlpha(200),
                      designController.taglineTextContainer.withAlpha(100),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: AutoSizeText(
                    widget.data['tagline'].toString(),
                    textAlign: designController.tagTextAlign,
                    style: GoogleFonts.getFont(
                      designController.taglineFontFamily,
                      color: designController.taglineFontColor,
                      fontSize: designController.taglineStyle.fontSize,
                      fontWeight: designController.taglineStyle.fontWeight,
                      wordSpacing: designController.taglineStyle.wordSpacing,
                      decoration: designController.taglineStyle.decoration,
                      height: designController.taglineStyle.height,
                      backgroundColor:
                          designController.taglineStyle.backgroundColor,
                      letterSpacing:
                          designController.taglineStyle.letterSpacing,
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
                  decoration: BoxDecoration(
                    color: designController.bottomContainerColor,
                    boxShadow: shadow,
                  ),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: designController.iconSize,
                        margin: spaceOnly(
                          bottom: designController.iconSpace,
                          left: designController.iconSpace,
                          right: designController.iconSpace,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              borderRadius(designController.iconRadius),
                          boxShadow: designController.iconShadow,
                        ),
                        child: CachedNetworkImage(
                          key: Key(getRandomString(20)),
                          imageUrl: widget.data['icon'],
                          fit: BoxFit.cover,
                          errorWidget: (c, url, obj) {
                            return Image.network(
                              widget.data['icon'],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      gap(w: 5),
                      Text.rich(
                        TextSpan(
                          text: '${widget.data['largeText'].toString()} ',
                          style: GoogleFonts.getFont(
                            designController.largeFontFamily,
                            color: designController.largeFontColor,
                            fontSize: designController.largeStyle.fontSize,
                            fontWeight: designController.largeStyle.fontWeight,
                            wordSpacing:
                                designController.largeStyle.wordSpacing,
                            decoration: designController.largeStyle.decoration,
                            height: designController.largeStyle.height,
                            backgroundColor:
                                designController.largeStyle.backgroundColor,
                            letterSpacing:
                                designController.largeStyle.letterSpacing,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${widget.data['smallText']} ',
                              style: GoogleFonts.getFont(
                                designController.smallFontFamily,
                                color: designController.smallFontColor,
                                fontSize: designController.smallStyle.fontSize,
                                fontWeight:
                                    designController.smallStyle.fontWeight,
                                wordSpacing:
                                    designController.smallStyle.wordSpacing,
                                decoration:
                                    designController.smallStyle.decoration,
                                height: designController.smallStyle.height,
                                backgroundColor:
                                    designController.smallStyle.backgroundColor,
                                letterSpacing:
                                    designController.smallStyle.letterSpacing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
