import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:barcontent/screen/design/design2/controller/design2_controller.dart';

class SlideUpReveal extends StatefulWidget {
  bool isAnimate;
  final Widget child;

  SlideUpReveal({
    Key? key,
    required this.isAnimate,
    required this.child,
  }) : super(key: key);

  @override
  State<SlideUpReveal> createState() => _SlideUpRevealState();
}

class _SlideUpRevealState extends State<SlideUpReveal> {
  bool _revealed = false;
  design2Controller designController = Get.put(design2Controller());

  @override
  void initState() {
    super.initState();
    // Start animation after build
    if (widget.isAnimate) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() => _revealed = true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = ((MediaQuery.of(context).size.width *
            (1 / designController.itemsPerScreen)) -
        8);

    return widget.isAnimate
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12), // optional rounded corners
            child: Stack(
              children: [
                widget.child, // actual content
                AnimatedPositioned(
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOut,
                  top: _revealed
                      ? -MediaQuery.of(context).size.height
                      : 0, // move up
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      width: (width - (designController.itemMarginH * 2)),
                      height: (Get.height - (designController.itemMarginV * 2)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            designController.animationContainerColor,
                            designController.animationContainerColor,
                            designController.animationContainerColor,
                            designController.animationContainerColor,
                            designController.animationContainerColor
                                .withAlpha(240),
                            designController.animationContainerColor
                                .withAlpha(100),
                          ],
                        ),
                        color: designController.animationContainerColor,
                        borderRadius:
                            borderRadius(designController.itemBorderRadius),
                      ),
                    ),
                  ), //  overlay
                ),
              ],
            ),
          )
        : widget.child;
  }
}
