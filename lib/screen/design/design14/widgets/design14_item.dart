import 'package:barcontent/screen/design/design14/controller/design14_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design14Item extends StatefulWidget {
  Map<String, dynamic> itemData;
  int index;
  Design14Item({
    Key? key,
    required this.itemData,
    required this.index,
  }) : super(key: key);

  @override
  State<Design14Item> createState() => _Design14ItemState();
}

class _Design14ItemState extends State<Design14Item> {
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
    return GetBuilder<Design14Controller>(
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
