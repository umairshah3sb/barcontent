import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:typewritertext/typewritertext.dart';

import 'package:barcontent/screen/design/design12/controller/design12_controller.dart';
import 'package:barcontent/screen/design/design13/controller/design13_controller.dart';
import 'package:barcontent/screen/design/design13/widgets/design13_text_animator.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design13Item extends StatefulWidget {
  Map<String, dynamic> itemData;
  int index;
  Design13Item({
    Key? key,
    required this.itemData,
    required this.index,
  }) : super(key: key);

  @override
  State<Design13Item> createState() => _Design13ItemState();
}

class _Design13ItemState extends State<Design13Item> {
  TypeWriterController? tcontroller;
  AnimateDesign() {
    tcontroller = TypeWriterController(
      text: widget.itemData['value1'],
      duration: const Duration(milliseconds: 100),
    );

    setState(() {});
  }

  @override
  void initState() {
    AnimateDesign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design13Controller>(
      builder: (controller) {
        return Container(
          margin: spacing(v: controller.valueContainerSpacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: controller.picContainerSize,
                child: CachedNetworkImage(
                  imageUrl: controller.csvData.isEmpty
                      ? '${controller.dumyData['icon']}'
                      : '${widget.itemData['icon']}',
                  fit: BoxFit.cover,
                ),
              ),
              gap(w: 10),
              Container(
                  width: controller.valueContainerWidth,
                  alignment: Alignment.centerLeft,
                  child: widget.index == controller.currentIndex
                      ? TypeWriter(
                          controller:
                              tcontroller, // valueController // streamController
                          builder: (context, value) {
                            return Container(
                              child: Text.rich(
                                TextSpan(
                                  text: '${widget.itemData['subtitle']}: ',
                                  children: [
                                    TextSpan(
                                      text: '${value.text.toString()}',
                                      children: [],
                                      style: controller.valueTextStyle.copyWith(
                                        color: controller.valueFontColor,
                                      ),
                                    ),
                                  ],
                                  style: controller.subTitleTextStyle.copyWith(
                                    color: controller.subtitleFontColor,
                                  ),
                                ),
                              ),
                            );
                          })
                      : Container(
                          child: Text.rich(
                            TextSpan(
                              text: '${widget.itemData['subtitle']}: ',
                              children: [
                                TextSpan(
                                  text:
                                      '${controller.csvData.isEmpty ? '${controller.dumyData['value1']}' : '${widget.itemData['value1']}'}',
                                  children: [],
                                  style: controller.valueTextStyle.copyWith(
                                    color: controller.valueFontColor,
                                  ),
                                ),
                              ],
                              style: controller.subTitleTextStyle.copyWith(
                                color: controller.subtitleFontColor,
                              ),
                            ),
                          ),
                        ))
            ],
          ),
        );
      },
    );
  }
}
