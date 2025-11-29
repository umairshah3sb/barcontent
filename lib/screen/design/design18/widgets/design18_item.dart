import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcontent/screen/design/design18/controller/design18_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:barcontent/util/helper.dart';
import 'package:google_fonts/google_fonts.dart';

// --- ThreeDBarPainter ---
/// A CustomPainter responsible for drawing the visible faces of the 3D-simulated
/// rectangular prism bar, along with its ground reflection and the connecting line.
class ThreeDBarPainter extends CustomPainter {
  final double barHeight;
  final double barWidth;
  final Color baseColor;
  final double depth;
  final bool isLastBar; // Determines if the connecting line should be drawn

  ThreeDBarPainter({
    required this.barHeight,
    required this.barWidth,
    required this.baseColor,
    required this.isLastBar,
    this.depth = 15.0, // Depth projection for 3D effect
  });

  @override
  void paint(Canvas canvas, Size size) {
    // --- Define Geometric Constants for a 4-Vertical-Face Rectangular Prism ---

    // Projection parameters
    final double xAngle = depth; // Horizontal projection of the side face
    final double yDepth = depth * 0.5; // Vertical projection of the side face
    final double halfWidth = barWidth / 2.0;

    final double totalAvailableHeight = size.height - yDepth;

    // Translate the canvas origin so (0,0) aligns with the top-left of the bar's base projection.
    canvas.translate(0, totalAvailableHeight - barHeight);

    // --- Define Points (T=Top, B=Bottom; FL=Front-Left, FR=Front-Right, BL=Back-Left, BR=Back-Right) ---
    // Top points (y = 0 for front, y = -yDepth for back)
    final Offset TFL = const Offset(0, 0);
    final Offset TFC = Offset(halfWidth, 0);
    final Offset TFR = Offset(barWidth, 0);
    final Offset TBR = Offset(barWidth + xAngle, -yDepth);
    final Offset TBL = Offset(xAngle, -yDepth);

    // Bottom points (y = barHeight for front, y = barHeight - yDepth for back)
    final Offset BFL = Offset(0, barHeight);
    final Offset BFC = Offset(halfWidth, barHeight);
    final Offset BFR = Offset(barWidth, barHeight);
    final Offset BBR = Offset(barWidth + xAngle, barHeight - yDepth);
    final Offset BBL = Offset(xAngle, barHeight - yDepth);

    // --- 1. Determine the colors/paints for the faces to simulate lighting ---
    final HSLColor hsl = HSLColor.fromColor(baseColor);

    // Top face is lightest
    final Color topColor =
        hsl.withLightness((hsl.lightness * 1.1).clamp(0.0, 1.0)).toColor();
    final Paint topPaint = Paint()..color = topColor;

    // Front faces (FL and FR) are bright with gradient
    final Color frontLight =
        hsl.withLightness((hsl.lightness * 0.95).clamp(0.0, 1.0)).toColor();
    final Color frontDark =
        hsl.withLightness((hsl.lightness * 0.85).clamp(0.0, 1.0)).toColor();

    final Paint frontPaint = Paint()
      ..shader = LinearGradient(
        colors: [frontLight, baseColor, frontDark],
        stops: const [0.0, 0.5, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(
          0, 0, barWidth, barHeight)); // Shader covers the full front width

    // Side faces (L and R) are slightly darker
    final Color sideDarkColor =
        hsl.withLightness((hsl.lightness * 0.80).clamp(0.0, 1.0)).toColor();
    final Paint sidePaint = Paint()..color = sideDarkColor;

    // --- 2. Drawing Faces (Back-to-Front for proper overlap) ---

    // a) Back-Left Face (L) - The vertical side face on the left
    final leftSidePath = Path()
      ..moveTo(TFL.dx, TFL.dy)
      ..lineTo(TBL.dx, TBL.dy)
      ..lineTo(BBL.dx, BBL.dy)
      ..lineTo(BFL.dx, BFL.dy)
      ..close();
    canvas.drawPath(leftSidePath, sidePaint);

    // b) Back-Right Face (R) - The vertical side face on the right
    final rightSidePath = Path()
      ..moveTo(TFR.dx, TFR.dy)
      ..lineTo(TBR.dx, TBR.dy)
      ..lineTo(BBR.dx, BBR.dy)
      ..lineTo(BFR.dx, BFR.dy)
      ..close();
    canvas.drawPath(rightSidePath, sidePaint);

    // c) Front-Left Face (FL) - The left half of the main front face
    final frontLeftFacePath = Path()
      ..moveTo(TFL.dx, TFL.dy)
      ..lineTo(TFC.dx, TFC.dy)
      ..lineTo(BFC.dx, BFC.dy)
      ..lineTo(BFL.dx, BFL.dy)
      ..close();
    canvas.drawPath(
        frontLeftFacePath, frontPaint); // Uses the full-width front gradient

    // d) Front-Right Face (FR) - The right half of the main front face
    final frontRightFacePath = Path()
      ..moveTo(TFC.dx, TFC.dy)
      ..lineTo(TFR.dx, TFR.dy)
      ..lineTo(BFR.dx, BFR.dy)
      ..lineTo(BFC.dx, BFC.dy)
      ..close();
    canvas.drawPath(
        frontRightFacePath, frontPaint); // Uses the full-width front gradient

    // e) Top Face (Square/Rhombus projection)
    final topPathFinal = Path()
      ..moveTo(TFL.dx, TFL.dy)
      ..lineTo(TFR.dx, TFR.dy)
      ..lineTo(TBR.dx, TBR.dy)
      ..lineTo(TBL.dx, TBL.dy)
      ..close();
    canvas.drawPath(topPathFinal, topPaint);

    // --- 3. Ground Reflection ---
    final double reflectionHeight = 30.0;

    final reflectionPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          baseColor.withOpacity(0.4),
          baseColor.withOpacity(0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(
          BFL.dx, BFL.dy, barWidth + xAngle, reflectionHeight + yDepth));

    // Reflection path mirrors the base (BFL, BFR, BBR, BBL), skewed downward
    final reflectionPath = Path()
      ..moveTo(BFL.dx, BFL.dy)
      ..lineTo(BFR.dx, BFR.dy)
      // Project the back right corner of the base downward
      ..lineTo(BBR.dx, BBR.dy + reflectionHeight)
      // Project the back left corner of the base downward
      ..lineTo(BBL.dx, BBL.dy + reflectionHeight)
      ..close();

    canvas.drawPath(reflectionPath, reflectionPaint);

    // --- 4. Connecting Line (Bar-to-Bar) ---
    if (!isLastBar) {
      final Paint linePaint = Paint()
        ..color = baseColor.withOpacity(0.7) // Use bar color for the line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0;

      // Start the line at the Front-Right corner of this bar's base.
      final Offset startPoint = BFR;
      // Extend the line horizontally into the padding area (15.0 matches the padding below)
      final Offset endPoint = Offset(BFR.dx + 15.0, BFR.dy);

      canvas.drawLine(startPoint, endPoint, linePaint);
    }
    // canvas.save();
    // canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ThreeDBarPainter oldDelegate) {
    return oldDelegate.barHeight != barHeight ||
        oldDelegate.baseColor != baseColor ||
        oldDelegate.isLastBar != isLastBar;
  }
}

// --- ThreeDBar Widget ---
/// The reusable widget that renders the 3D bar and ground effects, now including
/// an icon above the bar and a label overlaid on the bar.
class Design18Item extends StatefulWidget {
  Map<String, dynamic> data;
  final double value;
  final double maxValue;
  final Color color;
  final double barWidth;
  final double depth;
  final double maxBarAreaHeight;
  final bool isLastBar;

  Design18Item({
    Key? key,
    required this.data,
    required this.value,
    required this.maxValue,
    required this.color,
    this.barWidth = 150.0,
    this.depth = 15.0,
    required this.maxBarAreaHeight,
    required this.isLastBar,
  }) : super(key: key);

  @override
  State<Design18Item> createState() => _Design18ItemState();
}

class _Design18ItemState extends State<Design18Item> {
  @override
  Widget build(BuildContext context) {
    // Calculate the actual bar height
    final double barHeight =
        (widget.value / widget.maxValue) * widget.maxBarAreaHeight;

    // Total size needed to accommodate the bar, top projection, and reflection
    // Width must accommodate the main bar width and the side projection angle (depth)
    final double totalWidth = widget.barWidth + widget.depth;
    // Height must accommodate the max bar area and the vertical projection (yDepth, which is depth * 0.5)
    final double totalHeight = widget.maxBarAreaHeight + (widget.depth * 0.5);

    // Constant for the vertical projection amount
    final double yDepth = widget.depth * 0.5;

    return GetBuilder<Design18Controller>(builder: (controller) {
      return Container(
        margin: spacing(h: controller.spaceBetween),
        // We increase the width slightly for the line extending into the padding
        width: totalWidth + (widget.isLastBar ? 0 : 15.0),
        // Added space for ground reflection (30.0) AND extra space for the icon (20.0)
        height: totalHeight + 30.0 + 20.0,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // 1. Icon above the bar (positioned relative to the top of the bar projection)
            Positioned(
              left: 0,
              // Position the icon 5 units above the true top of the bar (max height)
              top: widget.maxBarAreaHeight -
                  barHeight -
                  controller.picBottomSpace,
              right: 0,
              child: Center(
                child: Container(
                  width: controller.picContainerWidth,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: borderRadius(0),
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

            // 2. The CustomPainter for the 3D Bar itself
            Positioned(
              left: 0,
              // Offset from the top to account for the icon's space
              top: 20.0,
              child: SizedBox(
                width: totalWidth + (widget.isLastBar ? 0 : 15.0),
                height: totalHeight + 30.0,
                child: CustomPaint(
                  painter: ThreeDBarPainter(
                    barHeight: barHeight,
                    barWidth: widget.barWidth,
                    baseColor: widget.color,
                    depth: widget.depth,
                    isLastBar: widget.isLastBar,
                  ),
                ),
              ),
            ),

            // 3. Label/Title on the bar
            // Positioned above the bar's base, centered horizontally.
            Positioned(
              // Start label slightly in from the left side projection
              bottom: 0.0 + 5.0, // Above reflection (30.0) + 5px margin
              child: Center(
                child: Container(
                  width: widget.barWidth,
                  height: barHeight,
                  alignment: Alignment.topCenter,
                  // Use a gradient background for the text for better visibility/style
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: controller.nameContainerWidth,
                        margin: spaceOnly(top: controller.nameTopSpacing),
                        padding: spacing(
                            h: controller.nameContainerPadding,
                            v: controller.nameContainerPadding),
                        decoration: BoxDecoration(
                          color: controller.nameBGColor,
                          borderRadius: borderRadius(
                            controller.nameContainerRadius,
                          ),
                        ),
                        child: AutoSizeText(
                          widget.data['name'].toString(),
                          textAlign: controller.nameTextAlign,
                          style: GoogleFonts.getFont(
                            controller.nameFontFamily,
                            color: controller.nameFontColor,
                            fontSize: controller.nameStyle.fontSize,
                            fontWeight: controller.nameStyle.fontWeight,
                            wordSpacing: controller.nameStyle.wordSpacing,
                            decoration: controller.nameStyle.decoration,
                            height: controller.nameStyle.height,
                            backgroundColor:
                                controller.nameStyle.backgroundColor,
                            letterSpacing: controller.nameStyle.letterSpacing,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 3,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        width: controller.valueContainerWidth,
                        margin: spaceOnly(top: controller.valueTopSpacing),
                        padding: spacing(
                            h: controller.valueContainerPadding,
                            v: controller.valueContainerPadding),
                        decoration: BoxDecoration(
                          color: controller.valueBGColor,
                          borderRadius: borderRadius(
                            controller.valueContainerRadius,
                          ),
                        ),
                        child: AutoSizeText(
                          '${widget.data['largeText'].toString()} ${widget.data['smallText'].toString()}',
                          textAlign: controller.valueTextAlign,
                          style: GoogleFonts.getFont(
                            controller.valueFontFamily,
                            color: controller.valueFontColor,
                            fontSize: controller.valueStyle.fontSize,
                            fontWeight: controller.valueStyle.fontWeight,
                            wordSpacing: controller.valueStyle.wordSpacing,
                            decoration: controller.valueStyle.decoration,
                            height: controller.valueStyle.height,
                            backgroundColor:
                                controller.valueStyle.backgroundColor,
                            letterSpacing: controller.valueStyle.letterSpacing,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.6),
                                blurRadius: 3,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
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

// --- GridBackgroundPainter ---
/// Draws a subtle grid pattern to simulate graph paper texture.
class GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.grey.shade200 // Very faint lines
      ..strokeWidth = 1.0;

    const double step = 20.0; // Grid step size

    // Draw vertical lines
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
