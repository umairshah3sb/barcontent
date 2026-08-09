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

/// Design16
/// Layout (top -> bottom):
///  1. Title, centered, above everything else (e.g. "Battle Tanks")
///  2. A row with the flags on the OUTER edges and the two country
///     names in BETWEEN them (Flag1 - Name1 - Name2 - Flag2)
///  3. The item image, centered
///  4. A row with the two values, one on each side, under the image
///
/// This reuses Design15Controller so it drops into the same
/// project/theming setup as Design15. If you want independent
/// theming controls (separate colors/sizes just for this design),
/// create a `Design16Controller extends Design15Controller` and swap
/// the type below.
class Design15Item2 extends StatefulWidget {
  int sec;
  Map<String, dynamic> itemData;
  // Optional override — falls back to controller.verserImage's text
  // field if you already store a title there, otherwise defaults to
  // 'Battle Tanks'.
  String? titleText;

  Design15Item2({
    Key? key,
    required this.sec,
    required this.itemData,
    this.titleText,
  }) : super(key: key);

  @override
  State<Design15Item2> createState() => _Design15Item2State();
}

class _Design15Item2State extends State<Design15Item2> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design15Controller>(
      builder: (controller) {
        return Stack(
          children: [
            Container(
              padding: spacing(h: controller.VideoContainerSpacingH),
              height: controller.VideoContainerHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildFlag(controller, isFirst: true),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: NameSlider(
                                key: Key(getRandomString(20)),
                                text: controller.name1.text.toString(),
                                fontSize: controller.nameTextSize,
                                fontWeight: FontWeight.w100,
                                color: controller.nameFontColor,
                              ),
                            ),
                            gap(h: 12),
                            Flexible(
                              child: NameSlider(
                                key: Key(getRandomString(20)),
                                text: controller.name2.text.toString(),
                                fontSize: controller.nameTextSize,
                                fontWeight: FontWeight.w100,
                                color: controller.nameFontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildFlag(controller, isFirst: false),
                    ],
                  ),
                  gap(h: 16),
                  Text(
                    widget.itemData['name'],
                    style: GoogleFonts.alfaSlabOne(
                      fontSize: controller.nameTextSize,
                      fontWeight: FontWeight.w800,
                      color: controller.nameFontColor,

                      shadows: [
                        Shadow(
                          color: controller.shadowColor.withAlpha(
                            (255 * (controller.textShadowOpacity / 10)).toInt(),
                          ),
                          offset: Offset.zero,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  gap(h: controller.picVgap),
                  // 3. IMAGE, centered
                  Center(
                    child: Container(
                      width: controller.picContainerWidth,
                      height: controller.picContainerHeight,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(
                          controller.picContainerRadius,
                        ),
                        border: Border.all(
                          color: controller.picBorderColor,
                          width: controller.picBorderSize,
                        ),
                      ),
                      child: SlideInSteps(
                        key: Key(getRandomString(20)),
                        pic: controller.csvData.isNotEmpty
                            ? widget.itemData['pic']
                            : widget.itemData['pic'].toString(),
                      ),
                    ),
                  ),
                  gap(h: controller.picVgap),
                ],
              ),
            ),
            Positioned(
              top: controller.valueContainerPosition,
              left: controller.valueContainerHSpacing,
              right: controller.valueContainerHSpacing,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SlideUpPauseDown(
                    key: Key(getRandomString(20)),
                    isFirst: true,
                    text: widget.itemData['value1'].toString(),
                    fontSize: controller.valueFontSize,
                    fontWeight: FontWeight.bold,
                    color: controller.valueFontColor,
                  ),
                  SlideUpPauseDown(
                    key: Key(getRandomString(20)),
                    isFirst: false,
                    text: widget.itemData['value2'].toString(),
                    fontSize: controller.valueFontSize,
                    fontWeight: FontWeight.bold,
                    color: controller.valueFontColor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlag(Design15Controller controller, {required bool isFirst}) {
    final imageUrl = isFirst
        ? (controller.logo1.text.isNotEmpty
              ? controller.logo1.text
              : 'https://flagcdn.com/w320/pk.png')
        : (controller.logo2.text.isNotEmpty
              ? controller.logo2.text
              : 'https://flagcdn.com/w320/in.png');

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0015) // perspective
        ..rotateX(-0.05) // slight tilt back
        ..rotateY(0.08), // slight tilt sideways
      child: Container(
        width: controller.flagContainerWidth * 0.55,
        height: controller.flagContainerHeight * 0.55,
        decoration: BoxDecoration(
          borderRadius: borderRadius(controller.logoRadius),
          border: Border.all(
            color: controller.flagBorderColor,
            width: controller.flagBorderSize,
          ),
          boxShadow: [
            // Soft ambient shadow (close, diffuse)
            BoxShadow(
              color: controller.flagShadowColor.withAlpha(
                (255 * (controller.flagShadowOpacity / 10) * 0.5).toInt(),
              ),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: -2,
            ),
            // Main directional shadow (depth)
            BoxShadow(
              color: controller.flagShadowColor.withAlpha(
                (255 * (controller.flagShadowOpacity / 10)).toInt(),
              ),
              blurRadius: 28.68,
              offset: const Offset(0, 20),
              spreadRadius: -4,
            ),
            // Far soft glow for extra lift off the background
            BoxShadow(
              color: controller.flagShadowColor.withAlpha(
                (255 * (controller.flagShadowOpacity / 10) * 0.35).toInt(),
              ),
              blurRadius: 45,
              offset: const Offset(0, 32),
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius(controller.logoRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // The flag image
              CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),

              // Subtle top-light glossy sheen (glass/waving-flag feel)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.05),
                        Colors.transparent,
                        Colors.black.withOpacity(0.08),
                      ],
                      stops: const [0.0, 0.25, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Diagonal highlight streak for a "polished" reflective edge
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.15,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Colors.transparent],
                            stops: [0.0, 0.4],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Inner border highlight for a "raised edge" 3D feel
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius(controller.logoRadius),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                      width: 1,
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

class Design16MainUI extends StatefulWidget {
  Map<String, dynamic> itemData;
  String? titleText;

  Design16MainUI({Key? key, required this.itemData, this.titleText})
    : super(key: key);

  @override
  State<Design16MainUI> createState() => _Design16MainUIState();
}

class _Design16MainUIState extends State<Design16MainUI> {
  final Design15Controller designController = Get.put(Design15Controller());

  @override
  Widget build(BuildContext context) {
    return Design15Item2(
      sec: 1,
      itemData: widget.itemData,
      titleText: widget.titleText,
    );
  }
}
