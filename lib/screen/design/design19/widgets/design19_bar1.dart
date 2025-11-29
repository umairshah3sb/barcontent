import 'package:flutter/material.dart';

/// Demo: a single cylinder (108M) plus a small row of examples.
class DemoChartRow extends StatelessWidget {
  const DemoChartRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          CylinderBar(
            value: 270,
            unitLabel: 'M',
            color: Color(0xFFE53935), // cinematic red
            maxValue: 270, // top of scale
            barWidth: 84,
            barMaxHeight: 280,
            baseDiameter: 120,
            baseLabelStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
            cityLabel: 'ATLANTA',
            showCityLabel: true,
            flag: _FlagEmoji('🇺🇸'),
          ),
          SizedBox(width: 40),
          CylinderBar(
            value: 92,
            unitLabel: 'M',
            color: Color(0xFF009688), // teal
            maxValue: 108,
            barWidth: 72,
            barMaxHeight: 240,
            baseDiameter: 110,
            cityLabel: 'DUBAI',
            showCityLabel: true,
            flag: _FlagEmoji('🇦🇪'),
          ),
          SizedBox(width: 40),
          CylinderBar(
            value: 77,
            unitLabel: 'M',
            color: Color(0xFFEF6C00), // orange
            maxValue: 108,
            barWidth: 68,
            barMaxHeight: 220,
            baseDiameter: 105,
            cityLabel: 'SHANGHAI',
            showCityLabel: true,
            flag: _FlagEmoji('🇨🇳'),
          ),
        ],
      ),
    );
  }
}

/// Simple flag widget using emoji for portability; you can swap for a PNG/SVG.
class _FlagEmoji extends StatelessWidget {
  final String emoji;
  const _FlagEmoji(this.emoji);

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: const TextStyle(fontSize: 28),
    );
  }
}

/// High-level widget composing base + cylinder + overlays.
class CylinderBar extends StatelessWidget {
  final double value; // e.g., 108
  final String unitLabel; // e.g., "M"
  final double maxValue; // e.g., 108 (for scaling)
  final Color color; // cylinder main color
  final double barWidth; // cylinder diameter
  final double barMaxHeight; // max height of cylinder at maxValue
  final double baseDiameter; // pedestal diameter
  final TextStyle? baseLabelStyle;
  final String? cityLabel; // optional city name under base
  final bool showCityLabel;
  final Widget? flag; // optional flag above cylinder
  final Duration animationDuration;

  const CylinderBar({
    super.key,
    required this.value,
    required this.unitLabel,
    required this.color,
    required this.maxValue,
    this.barWidth = 80,
    this.barMaxHeight = 280,
    this.baseDiameter = 120,
    this.baseLabelStyle,
    this.cityLabel,
    this.showCityLabel = false,
    this.flag,
    this.animationDuration = const Duration(milliseconds: 900),
  });

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0, maxValue);
    final height = (clamped / maxValue) * barMaxHeight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (flag != null) ...[
          flag!,
          const SizedBox(height: 10),
        ],
        // Cylinder + base stacked
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Cylinder rises from base
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: height),
              duration: animationDuration,
              curve: Curves.easeOutCubic,
              builder: (context, animatedHeight, child) {
                return SizedBox(
                  width: barWidth,
                  height: animatedHeight +
                      _CylinderPainter.topEllipseHeight(barWidth),
                  child: CustomPaint(
                    painter: _CylinderPainter(color: color),
                  ),
                );
              },
            ),
            // Base
            // SizedBox(
            //   width: baseDiameter,
            //   height: baseDiameter, // slim circular pedestal feel
            //   child: CustomPaint(
            //     painter: BasePedestalPainter(
            //       label: '${value.toStringAsFixed(0)}$unitLabel',
            //       labelStyle: baseLabelStyle ??
            //           const TextStyle(
            //             fontSize: 22,
            //             fontWeight: FontWeight.w800,
            //             color: Colors.black,
            //           ),
            //     ),
            //   ),
            // ),
          ],
        ),
        if (showCityLabel && cityLabel != null) ...[
          const SizedBox(height: 10),
          Text(
            cityLabel!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.black87,
            ),
          ),
        ],
      ],
    );
  }
}

/// Painter for the white base pedestal with soft shadow and bold label.
class BasePedestalPainter extends CustomPainter {
  final String label;
  final TextStyle labelStyle;

  BasePedestalPainter({
    required this.label,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final center = Offset(w / 2, h / 2);

    // Shadow underneath
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawOval(
        Rect.fromCenter(
            center: center.translate(0, h * 0.12),
            width: w * 0.92,
            height: h * 0.35),
        shadowPaint);

    // Base top ellipse (white)
    final basePaint = Paint()..color = Colors.white;
    canvas.drawOval(
        Rect.fromCenter(center: center, width: w * 0.92, height: h * 0.5),
        basePaint);

    // Subtle rim
    final rimPaint = Paint()..color = const Color(0xFFE0E0E0);
    canvas.drawOval(
        Rect.fromCenter(
            center: center.translate(0, -h * 0.02),
            width: w * 0.88,
            height: h * 0.42),
        rimPaint);

    // Label
    final tp = TextPainter(
      text: TextSpan(text: label, style: labelStyle),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: w);
    tp.paint(canvas, Offset((w - tp.width) / 2, (h - tp.height) / 2 - 2));
  }

  @override
  bool shouldRepaint(covariant BasePedestalPainter oldDelegate) {
    return oldDelegate.label != label || oldDelegate.labelStyle != labelStyle;
  }
}

/// Painter for a glossy vertical cylinder with an elliptical top.
class _CylinderPainter extends CustomPainter {
  final Color color;
  _CylinderPainter({required this.color});

  static double topEllipseHeight(double barWidth) => barWidth * 0.28;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final topH = topEllipseHeight(w);
    final bodyH = (h - topH).clamp(0.0, double.infinity);

    // Cylinder body gradient (left-to-right shading)
    final bodyGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        darken(color, 0.18),
        color,
        lighten(color, 0.12),
      ],
    ).createShader(Rect.fromLTWH(0, topH, w, bodyH));

    final bodyPaint = Paint()..shader = bodyGradient;
    final bodyRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, topH + 5, w, bodyH),
      topLeft: Radius.circular(w / 4),
      topRight: Radius.circular(w / 4),
      bottomLeft: Radius.circular(w / 4),
      bottomRight: Radius.circular(w / 4),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    final bottomPaint = Paint()..shader = bodyGradient;
    final bottomRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(-(w * 0.15), bodyH - 10, w + w * 0.3, 40),
      topLeft: Radius.circular(7),
      topRight: Radius.circular(7),
      bottomLeft: Radius.circular(7),
      bottomRight: Radius.circular(7),
    );
    canvas.drawRRect(bottomRect, bottomPaint);

    // Specular highlight (soft vertical strip)
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withAlpha(0),
          Colors.white.withAlpha(70),
          Colors.white.withAlpha(0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(
          Rect.fromLTWH(w * 0.58, topH + bodyH * 0.11, w * 0.12, bodyH * 0.85));
    canvas.drawRect(
        Rect.fromLTWH(w * 0.58, topH + bodyH * 0.11, w * 0.12, bodyH * 0.85),
        highlightPaint);

    // Rim shadow at bottom
    final rimShadow = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withAlpha(20),
          Colors.black.withAlpha(120),
        ],
      ).createShader(Rect.fromLTWH(0, topH + bodyH - w * 0.12, w, w * 0.12));
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, topH + bodyH - w * 0.14, w, w * 0.2),
        bottomLeft: Radius.circular(w / 4),
        bottomRight: Radius.circular(w / 4),
      ),
      rimShadow,
    );

    final rimTopShadow = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withAlpha(30),
          Colors.black.withAlpha(140),
        ],
      ).createShader(Rect.fromLTWH(0, topH + bodyH - w * 0.12, w, w * 0.12));
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, topH + w * 0.09, w, w * 0.2),
        topLeft: Radius.circular(w / 4),
        topRight: Radius.circular(w / 4),
      ),
      rimTopShadow,
    );
    // Top ellipse (cap) with radial light
    final topRect = Rect.fromLTWH(0, 0, w, topH);
    final topGradient = RadialGradient(
      center: Alignment.topCenter,
      radius: 1.2,
      colors: [
        lighten(color, 0.20),
        darken(color, 0.10),
      ],
    ).createShader(topRect);
    final topPaint = Paint()..shader = topGradient;
    canvas.drawOval(topRect, topPaint);

    // Top highlight line
    final topHighlight = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawOval(
      Rect.fromLTWH(w * 0.06, topH * 0.06, w * 0.88, topH * 0.88),
      topHighlight,
    );

    // Drop shadow behind cylinder
    final dropShadow = Paint()
      ..color = Colors.black.withOpacity(0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w / 2, topH + bodyH),
        width: w * 0.9,
        height: w * 0.22,
      ),
      dropShadow,
    );
  }

  @override
  bool shouldRepaint(covariant _CylinderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

/// Color utilities (lighten/darken by fraction 0..1)
Color lighten(Color c, double amount) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(c);
  final light = (hsl.lightness + amount).clamp(0.0, 1.0);
  return hsl.withLightness(light).toColor();
}

Color darken(Color c, double amount) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(c);
  final light = (hsl.lightness - amount).clamp(0.0, 1.0);
  return hsl.withLightness(light).toColor();
}
