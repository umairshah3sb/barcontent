import 'package:barcontent/screen/design/design17/controller/design17_controller.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Design17Animated extends StatefulWidget {
  bool isAnimate;
  final Widget child;

  Design17Animated({
    Key? key,
    required this.isAnimate,
    required this.child,
  }) : super(key: key);

  @override
  State<Design17Animated> createState() => _Design17AnimatedState();
}

class _Design17AnimatedState extends State<Design17Animated> {
  bool _revealed = false;
  Design17Controller designController = Get.put(Design17Controller());

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
                      ? -(MediaQuery.of(context).size.height)
                      : 0, // move up
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      width: (designController.itemsWidth -
                          (designController.itemMarginH * 2)),
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
                  ), // overlay
                ),
              ],
            ),
          )
        : widget.child;
  }
}
