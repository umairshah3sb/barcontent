import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcontent/screen/design/design9/controller/design9_controller.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:barcontent/util/helper.dart';

class Design9Item extends StatefulWidget {
  Map<String, dynamic> data;
  int index = 0;
  Design9Item({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  State<Design9Item> createState() => _Design9ItemState();
}

class _Design9ItemState extends State<Design9Item> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Design9Controller>(builder: (controller) {
      return Stack(
        children: [
          Container(
            width: controller.dataContainerWidth,
            margin: spacing(v: controller.dataContainerSpacing),
            child: SizedBox(
              height: controller.valueContainerSize,
              child: Center(
                child: Container(
                  height: controller.dataContainerHeight,
                  width: double.infinity,
                  padding: spacing(h: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: controller.valueWidth,
                        height: controller.dataContainerHeight,
                        padding: spacing(h: controller.valueContainerSpacing),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: widget.index.isOdd
                              ? controller.valueContainerLeft
                              : controller.valueContainerRight,
                          borderRadius: borderRadius(
                            controller.valueContainerRadius,
                          ),
                        ),
                        child: AutoSizeText(
                          widget.data['value1'].toString(),
                          style: controller.valueTextStyle.copyWith(
                            color: widget.index.isOdd
                                ? controller.valueFontColor1
                                : controller.valueFontColor2,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: controller.valueWidth,
                        height: controller.dataContainerHeight,
                        alignment: Alignment.centerLeft,
                        padding: spacing(h: controller.valueContainerSpacing),
                        decoration: BoxDecoration(
                          color: widget.index.isOdd
                              ? controller.valueContainerRight
                              : controller.valueContainerLeft,
                          borderRadius: borderRadius(
                            controller.valueContainerRadius,
                          ),
                        ),
                        child: AutoSizeText(
                          widget.data['value2'].toString(),
                          style: controller.valueTextStyle.copyWith(
                            color: widget.index.isOdd
                                ? controller.valueFontColor2
                                : controller.valueFontColor1,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: Container(
                height: controller.picContainerSize,
                decoration: BoxDecoration(
                  borderRadius: borderRadius(
                    controller.picContainerRadius,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: borderRadius(
                    controller.picContainerRadius,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.data['pic'],
                    color: controller.picIconColor,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
