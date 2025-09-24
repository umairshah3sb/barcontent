import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:barcontent/screen/design/design2/controller/design2_controller.dart';
import 'package:barcontent/screen/design/design2/widget/reveal_animation.dart';
import 'package:barcontent/util/helper.dart';

class Design2Item extends StatefulWidget {
  Map<String, dynamic> data;
  bool isAnimate;
  int index;
  Design2Item({
    Key? key,
    required this.data,
    this.isAnimate = false,
    this.index = 0,
  }) : super(key: key);

  @override
  State<Design2Item> createState() => _Design2ItemState();
}

class _Design2ItemState extends State<Design2Item> {
  design2Controller designController = Get.put(design2Controller());
  @override
  Widget build(BuildContext context) {
    return SlideUpReveal(
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
                            imageUrl: widget.data['pic1'],
                            fit: BoxFit.cover,
                            errorWidget: (c, url, obj) {
                              return Image.network(
                                widget.data['pic1'],
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
                  color: designController.nameContainerColor,
                  boxShadow: shadow,
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      widget.data['name'].toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        color: designController.nameFontColor,
                        fontSize: designController.nameFontSize.toDouble(),
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            color: Color(0x26442A7C),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                          Shadow(
                            color: Color(0x26442A7C),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: (designController.itemMarginH * 2),
              ),
              Container(
                width: designController.itemsWidth,
                height: designController.largContainerHeight,
                decoration: BoxDecoration(
                  color: designController.LargeTextContainer,
                  boxShadow: shadow,
                ),
                child: FittedBox(
                    child: Container(
                  margin: spaceOnly(top: 40, bottom: 5),
                  child: Text.rich(
                    TextSpan(
                      text: widget.data['largeText'].toString(),
                      style: GoogleFonts.manrope(
                        color: designController.largeFontColor,
                        fontWeight: FontWeight.w900,
                        fontSize: designController.largTextSize,
                        height: -0.9,
                      ),
                      children: [
                        TextSpan(
                          text: widget.data['smallText'],
                          style: GoogleFonts.manrope(
                            color: designController.smallFontColor,
                            height: -1,
                            fontWeight: FontWeight.w900,
                            fontSize: designController.smallTextSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
              SizedBox(
                height: designController.spaceBetween.toDouble(),
              ),
              Expanded(
                child: Container(
                  width: designController.itemsWidth,
                  decoration: BoxDecoration(
                    color: designController.pic2ContainerColor,
                  ),
                  child: Center(
                    child: Container(
                      width: designController.pic2Width,
                      height: designController.pic2Height,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(designController.pic2Radius),
                        border: Border.all(
                          width: designController.pic2Border,
                          color: designController.pic2BorderColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: borderRadius(designController.pic2Radius),
                        child: CachedNetworkImage(
                          imageUrl: widget.data['pic2'],
                          fit: BoxFit.cover,
                        ),
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
