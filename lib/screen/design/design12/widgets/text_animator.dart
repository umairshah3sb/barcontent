import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:typewritertext/typewritertext.dart';

import 'package:barcontent/screen/design/design12/controller/design12_controller.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class TextAnimator extends StatefulWidget {
  String text;
  int delayInSeconds;
  TextStyle style;
  int maxlines;
  TextAlign textAlign;
  TextOverflow overflow;
  TextAnimator({
    Key? key,
    required this.text,
    required this.delayInSeconds,
    required this.style,
    required this.maxlines,
    required this.textAlign,
    required this.overflow,
  }) : super(key: key);

  @override
  State<TextAnimator> createState() => _TextAnimatorState();
}

class _TextAnimatorState extends State<TextAnimator> {
  TypeWriterController? tcontroller;
  AnimateDesign() {
    Timer(Duration(seconds: widget.delayInSeconds), () {
      tcontroller = TypeWriterController(
        text: widget.text,
        duration: const Duration(milliseconds: 50),
      );

      setState(() {});
    });
  }

  @override
  void initState() {
    AnimateDesign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design12Controller>(builder: (controller) {
      return tcontroller != null
          ? Container(
              width: Get.width * 4,
              alignment: Alignment.center,
              child: TypeWriter(
                  controller:
                      tcontroller, // valueController // streamController
                  builder: (context, value) {
                    return AutoSizeText(
                      value.text.replaceAll(',', '\n').replaceAll('/', '\n'),
                      style: widget.style,
                      maxLines: widget.maxlines,
                      textAlign: widget.textAlign,
                      overflow: widget.overflow,
                    );
                  }),
            )
          : gap();
    });
  }
}
