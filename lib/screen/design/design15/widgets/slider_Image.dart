import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcontent/screen/design/design15/controller/design15_controller.dart';

class SlideInSteps extends StatefulWidget {
  String pic;
  SlideInSteps({Key? key, required this.pic}) : super(key: key);
  @override
  _SlideInStepsState createState() => _SlideInStepsState();
}

class _SlideInStepsState extends State<SlideInSteps>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;
  Design15Controller designcontroller = Get.put(Design15Controller());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6), // total timeline (not critical here)
    );

    _slideAnim = Tween<Offset>(
      begin: Offset(0, -1), // start above container
      end: Offset(0, 3), // end below container
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Opacity tied to the SAME controller:
    // 0 -> 0.25   : fade in  (0 -> 1)   -> matches step 1 (entering from top)
    // 0.25 -> 0.75: stay fully visible  -> matches steps 2 & 3
    // 0.75 -> 1.0 : fade out (1 -> 0)   -> matches step 4 (exiting at bottom)
    _fadeAnim = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 25,
      ),
    ]).animate(_controller);

    _startStepAnimation();
  }

  Future<void> _startStepAnimation() async {
    // Move in 4 equal steps
    for (int i = 1; i <= 4; i++) {
      await _controller.animateTo(
        i * 0.25,
        duration: Duration(milliseconds: 600),
      ); // smooth slide step
      await Future.delayed(Duration(seconds: 4)); // pause 4s at each stop
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:
            ((designcontroller.picContainerWidth) -
            designcontroller.picHMargin),
        height:
            ((designcontroller.picContainerHeight) -
            designcontroller.picVMargin),
        child: ClipRect(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: designcontroller.picBackground,
                  child: CachedNetworkImage(
                    imageUrl: widget.pic,
                    fit: BoxFit.cover,
                    width:
                        ((4 * designcontroller.picContainerWidth) -
                        designcontroller.picHMargin),
                    height:
                        ((3 * designcontroller.picContainerHeight) -
                        designcontroller.picVMargin),
                    errorWidget: (context, url, error) {
                      return Image.network(
                        widget.pic,
                        fit: BoxFit.cover,
                        width:
                            ((4 * designcontroller.picContainerWidth) -
                            designcontroller.picHMargin),
                        height:
                            ((3 * designcontroller.picContainerHeight) -
                            designcontroller.picVMargin),
                      );
                    },
                    placeholder: (context, url) {
                      return Image.network(
                        widget.pic,
                        fit: BoxFit.cover,
                        width:
                            ((4 * designcontroller.picContainerWidth) -
                            designcontroller.picHMargin),
                        height:
                            ((3 * designcontroller.picContainerHeight) -
                            designcontroller.picVMargin),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
