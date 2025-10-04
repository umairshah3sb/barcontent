import 'package:barcontent/util/helper.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:get/get.dart';

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

    canvas.restore();
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
class ThreeDBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final Color color;
  final double barWidth;
  final double depth;
  final double maxBarAreaHeight;
  final bool isLastBar;
  final IconData iconData; // New property for the icon above
  final String barLabel; // New property for the label on the bar

  const ThreeDBar({
    super.key,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.maxBarAreaHeight,
    required this.isLastBar,
    required this.iconData, // Required in constructor
    required this.barLabel, // Required in constructor
    this.barWidth = 150.0,
    this.depth = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the actual bar height
    final double barHeight = (value / maxValue) * maxBarAreaHeight;

    // Total size needed to accommodate the bar, top projection, and reflection
    // Width must accommodate the main bar width and the side projection angle (depth)
    final double totalWidth = barWidth + depth;
    // Height must accommodate the max bar area and the vertical projection (yDepth, which is depth * 0.5)
    final double totalHeight = maxBarAreaHeight + (depth * 0.5);

    // Constant for the vertical projection amount
    final double yDepth = depth * 0.5;

    return SizedBox(
      // We increase the width slightly for the line extending into the padding
      width: totalWidth + (isLastBar ? 0 : 15.0),
      // Added space for ground reflection (30.0) AND extra space for the icon (20.0)
      height: totalHeight + 30.0 + 20.0,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // 1. Icon above the bar (positioned relative to the top of the bar projection)
          Positioned(
            left: 0,
            // Position the icon 5 units above the true top of the bar (max height)
            top: maxBarAreaHeight - barHeight - 20.0,
            child: Container(
              width: totalWidth,
              alignment: Alignment.center,
              child: Icon(
                iconData,
                size: 50,
                color: color.withOpacity(0.9),
              ),
            ),
          ),

          // 2. The CustomPainter for the 3D Bar itself
          Positioned(
            left: 0,
            // Offset from the top to account for the icon's space
            top: 20.0,
            child: SizedBox(
              width: totalWidth + (isLastBar ? 0 : 15.0),
              height: totalHeight + 30.0,
              child: CustomPaint(
                painter: ThreeDBarPainter(
                  barHeight: barHeight,
                  barWidth: barWidth,
                  baseColor: color,
                  depth: depth,
                  isLastBar: isLastBar,
                ),
              ),
            ),
          ),

          // 3. Label/Title on the bar
          // Positioned above the bar's base, centered horizontally.
          Positioned(
            left:
                yDepth, // Start label slightly in from the left side projection
            bottom: 0.0 + 5.0, // Above reflection (30.0) + 5px margin
            child: Container(
              width: barWidth,
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
              child: Padding(
                padding: spaceOnly(top: 40),
                child: Text(
                  barLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    // Add a subtle text shadow for readability against the gradient
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 3,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

// --- Main Application ---

/// A simple example showing the ThreeDBar widget in a Row (chart context).
class ThreeDBarChartExample extends StatelessWidget {
  const ThreeDBarChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample Data (Value, Color, Label, Icon)
    final List<Map<String, dynamic>> chartData = [
      {
        'value': 150.0,
        'color': const Color(0xFFFF9800),
        'label': 'Q1',
        'icon': Icons.flash_on,
        'bar_label': '\$150k'
      }, // Orange
      {
        'value': 180.0,
        'color': const Color(0xFF4CAF50),
        'label': 'Q2',
        'icon': Icons.trending_up,
        'bar_label': '\$180k'
      }, // Green
      {
        'value': 120.0,
        'color': const Color(0xFF9C27B0),
        'label': 'Q3',
        'icon': Icons.trending_down,
        'bar_label': '\$120k'
      }, // Purple
      {
        'value': 165.0,
        'color': const Color(0xFFF44336),
        'label': 'Q4',
        'icon': Icons.star,
        'bar_label': '\$165k'
      }, // Red
    ];

    const double maxValue = 200.0;
    double maxBarAreaHeight = Get.height * 0.8; // Max height for the bars
    const double barDepth = 15.0;
    const double barWidth = 150.0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Using a very light off-white color for the overall background
        backgroundColor: const Color(0xFFF7F7F7),

        body: Center(
          child: Container(
            // Removed internal container decoration to let the background show through
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Chart area wrapper
                Container(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    // Increased height to accommodate the icon above the max height
                    height: maxBarAreaHeight + barDepth + 40.0 + 30.0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize:
                                MainAxisSize.min, // Wrap content horizontally
                            children: chartData.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> data = entry.value;
                              bool isLast = index == chartData.length - 1;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ThreeDBar(
                                      value: data['value'] as double,
                                      maxValue: maxValue,
                                      color: data['color'] as Color,
                                      maxBarAreaHeight: maxBarAreaHeight,
                                      depth: barDepth,
                                      barWidth: barWidth,
                                      isLastBar: isLast,
                                      iconData:
                                          data['icon'] as IconData, // Pass icon
                                      barLabel: data['bar_label']
                                          as String, // Pass bar label
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
