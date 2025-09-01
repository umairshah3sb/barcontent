import 'package:flutter/material.dart';
import 'dart:math' as math;

class RedScrollBanner extends StatelessWidget {
  final double width;
  final double height;

  const RedScrollBanner({
    super.key,
    this.width = 300,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(-0.05) // small tilt on X
        ..rotateY(-0.05), // small tilt on Y
      child: CustomPaint(
        size: Size(width, height),
        painter: RedScroll3DPainter(),
      ),
    );
  }
}

class RedScroll3DPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double edgeWidth = size.width * 0.15;

    /// Center gradient (slightly lighter in the middle)
    final Paint centerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.red.shade900,
          Colors.red.shade600,
          Colors.red.shade900,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(edgeWidth, 0, size.width - edgeWidth * 2, size.height));

    canvas.drawRect(
      Rect.fromLTWH(edgeWidth, 0, size.width - edgeWidth * 2, size.height),
      centerPaint,
    );

    /// Left roll
    _drawRoll(canvas, size, edgeWidth, isLeft: true);

    /// Right roll
    _drawRoll(canvas, size, edgeWidth, isLeft: false);
  }

  void _drawRoll(Canvas canvas, Size size, double edgeWidth, {required bool isLeft}) {
    double xStart = isLeft ? 0 : size.width - edgeWidth;
    double xEnd = isLeft ? edgeWidth : size.width;
    double shadowDir = isLeft ? 1 : -1;

    /// Roll body with radial shading for 3D curve
    final Paint rollPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.red.shade800,
          Colors.red.shade500,
          Colors.red.shade800,
        ],
        radius: 1.0,
        center: isLeft ? Alignment.centerRight : Alignment.centerLeft,
      ).createShader(Rect.fromLTWH(xStart, 0, edgeWidth, size.height));

    Path rollPath = Path()
      ..moveTo(xStart, 0)
      ..quadraticBezierTo(
          xStart + shadowDir * edgeWidth / 2, size.height / 2, xStart, size.height)
      ..lineTo(xEnd, size.height)
      ..quadraticBezierTo(
          xEnd - shadowDir * edgeWidth / 2, size.height / 2, xEnd, 0)
      ..close();

    canvas.drawPath(rollPath, rollPaint);

    /// Inner shadow
    final Paint shadowPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.black.withOpacity(0.4),
          Colors.transparent,
        ],
        begin: isLeft ? Alignment.centerRight : Alignment.centerLeft,
        end: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      ).createShader(Rect.fromLTWH(xStart, 0, edgeWidth, size.height));
    canvas.drawPath(rollPath, shadowPaint);

    /// Highlight
    final Paint highlightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.35),
          Colors.transparent,
        ],
        begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
      ).createShader(Rect.fromLTWH(xStart, 0, edgeWidth, size.height));
    canvas.drawPath(rollPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

