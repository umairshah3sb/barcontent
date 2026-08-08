import 'dart:async';
import 'dart:typed_data';

import 'package:auto_scroll_row/auto_scroll_row.dart';
import 'package:auto_scroll_slider/auto_scroll_slider.dart';
import 'package:barcontent/screen/design/design1/controller/design1_controller.dart';
import 'package:barcontent/screen/design/design2/controller/design2_controller.dart';
import 'package:barcontent/screen/design/design2/widget/design2_item.dart';
import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';
import 'package:barcontent/util/meta_data_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class Design2 extends StatefulWidget {
  const Design2({super.key});

  @override
  State<Design2> createState() => _Design2State();
}

class _Design2State extends State<Design2> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final design2Controller designController = Get.put(design2Controller());
  TextEditingController videoTimer = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: GetBuilder<design2Controller>(
        builder: (controller) {
          return Stack(
            children: [
              Container(
                key: Key(getRandomString(20)),
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                  image: backgroundImage.text.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(backgroundImage.text),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: designController.aspectRatio,
                    child: controller.isGenerating
                        ? controller.isAnimate
                              ? Row(children: controller.animatedItem)
                              : AutoScrollRow(
                                  reverse: false,
                                  enableUserScroll: false,
                                  scrollDuration: Duration(
                                    seconds: controller.videoDuration,
                                  ),
                                  children: List.generate(
                                    ((controller.csvData.length + 1)),
                                    (i) {
                                      if (i == controller.csvData.length) {
                                        return Container(
                                          width: Get.width * 1.5,
                                        );
                                      }
                                      return controller.csvData[(i)]['index']
                                              .toString()
                                              .isNotEmpty
                                          ? Design2Item(
                                              data: controller.csvData[(i)],
                                            )
                                          : gap();
                                    },
                                  ),
                                )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                (controller.csvData.length),
                                (i) {
                                  return controller.csvData[(i)]['index']
                                          .toString()
                                          .isNotEmpty
                                      ? Design2Item(
                                          data: controller.csvData[(i)],
                                        )
                                      : gap();
                                },
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              controller.isGenerating
                  ? gap()
                  : Positioned(
                      top: 15,
                      left: 15,
                      child: InkWell(
                        onTap: () {
                          _Key.currentState!.openDrawer();

                          setState(() {});
                        },
                        child: Container(
                          padding: spacing(h: 7, v: 7),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: borderRadius(50),
                          ),
                          child: Icon(Icons.menu, color: halfBlack, size: 25),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Future<void> pickAndReadCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String csvString = utf8.decode(fileBytes);
      List<List<dynamic>> data = const CsvToListConverter().convert(csvString);
      if (data.isNotEmpty) {
        List<String> headers = data.first.map((e) => e.toString()).toList();
        List<Map<String, dynamic>> dataAsMap = [];

        for (int i = 1; i < data.length; i++) {
          Map<String, dynamic> row = {};
          for (int j = 0; j < headers.length; j++) {
            row[headers[j]] = data[i][j];
          }
          dataAsMap.add(row);
        }

        setState(() {
          designController.csvData = dataAsMap.reversed.toList();
        });
      }
    }
  }

  Widget drawerWidget() {
    return Container(
      width: Get.width * 0.5,
      padding: spacing(v: 12, h: 12),
      height: Get.height,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: radiusOnly(topRight: 20, bottomRight: 20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                pickAndReadCsv();
              },
              child: Container(
                padding: spacing(h: 15, v: 7),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: borderRadius(10),
                ),
                child: Text(
                  'Choose file',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            gap(h: 15),
            Row(
              children: [
                Container(
                  width: 300,
                  height: 50,
                  padding: spacing(h: 14),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: shadow,
                    borderRadius: borderRadius(50),
                    border: Border.all(width: 2, color: halfBlack),
                  ),
                  child: TextFormField(
                    controller: videoTimer,
                    decoration: InputDecoration(
                      hintText: 'Enter video duration in seconds',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: halfBlack,
                      ),
                    ),
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: halfBlack,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 50,
                  padding: spacing(h: 14),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: shadow,
                    borderRadius: borderRadius(50),
                    border: Border.all(width: 2, color: halfBlack),
                  ),
                  child: TextFormField(
                    controller: backgroundImage,
                    onChanged: (x) {
                      designController.update();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Background Image Url',
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: halfBlack,
                      ),
                    ),
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: halfBlack,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            Container(
              padding: spacing(h: 15, v: 15),
              margin: spacing(v: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(width: 2, color: halfBlack),
                borderRadius: borderRadius(60),
                boxShadow: shadow,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Aspect Ratio'),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              designController.aspectRatio = 9 / 16;
                              designController.update();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: halfBlack),
                                borderRadius: borderRadius(50),
                              ),
                              child: Center(
                                child: Text(
                                  '9/16',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              designController.aspectRatio = 16 / 9;
                              designController.update();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: halfBlack),
                                borderRadius: borderRadius(50),
                              ),
                              child: Center(
                                child: Text(
                                  '16/9',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              designController.aspectRatio = 3 / 4;
                              designController.update();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: halfBlack),
                                borderRadius: borderRadius(50),
                              ),
                              child: Center(
                                child: Text('3/4', textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              designController.aspectRatio = 4 / 3;
                              designController.update();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: halfBlack),
                                borderRadius: borderRadius(50),
                              ),
                              child: Center(
                                child: Text('4/3', textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              designController.aspectRatio = 1 / 1;
                              designController.update();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: halfBlack),
                                borderRadius: borderRadius(50),
                              ),
                              child: Center(
                                child: Text('1/1', textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ],
                      ),
                      NewValueSlider(
                        max: 2000,
                        value: designController.itemsWidth,
                        title:
                            'Item Width: ${designController.itemsWidth.toInt()}',
                        onChanged: (value) {
                          designController.itemsWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Space Between Sections',
                        fontSize: designController.spaceBetween,
                        increase: () {
                          designController.spaceBetween++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.spaceBetween--;
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 200,
                        value: designController.itemBorderRadius,
                        title:
                            'Item Border Radius: ${designController.itemBorderRadius.toInt()}',
                        onChanged: (value) {
                          designController.itemBorderRadius = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 200,
                        value: designController.itemMarginH,
                        title:
                            'Item Margin Horizetal: ${designController.itemMarginH.toDouble().toInt()}',
                        onChanged: (value) {
                          designController.itemMarginH = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 200,
                        value: designController.itemMarginV,
                        title:
                            'Item Margin Vertical: ${designController.itemMarginV.toDouble().toInt()}',
                        onChanged: (value) {
                          designController.itemMarginV = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 200,
                        value: designController.nameFontSize,
                        title:
                            'Name Font Size: ${designController.nameFontSize.toInt()}',
                        onChanged: (value) {
                          designController.nameFontSize = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 300,
                        value: designController.nameContainerHeight,
                        title:
                            'Name Countainer Height: ${designController.nameContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.nameContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 200,
                        value: designController.largTextSize,
                        title:
                            'Large Text Font Size: ${designController.largTextSize.toInt()}',
                        onChanged: (value) {
                          designController.largTextSize = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 300,
                        value: designController.largContainerHeight,
                        title:
                            'Large Text Container Height: ${designController.largContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.largContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 300,
                        value: designController.smallTextSize,
                        title:
                            'Small Text Font Size: ${designController.smallTextSize.toInt()}',
                        onChanged: (value) {
                          designController.smallTextSize = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic1ContainerHeight,
                        title:
                            'Pic1 Container Height: ${designController.pic1ContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.pic1ContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic1Width,
                        title:
                            'Pic1 Width: ${designController.pic1Width.toInt()}',
                        onChanged: (value) {
                          designController.pic1Width = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic1Height,
                        title:
                            'Pic1 Height: ${designController.pic1Height.toInt()}',
                        onChanged: (value) {
                          designController.pic1Height = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic1Radius,
                        title:
                            'Pic1 Radius: ${designController.pic1Radius.toInt()}',
                        onChanged: (value) {
                          designController.pic1Radius = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic1Border,
                        title:
                            'Pic1 Border: ${designController.pic1Border.toInt()}',
                        onChanged: (value) {
                          designController.pic1Border = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic2Width,
                        title:
                            'Pic2 Width: ${designController.pic2Width.toInt()}',
                        onChanged: (value) {
                          designController.pic2Width = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic2Height,
                        title:
                            'Pic2 Height: ${designController.pic2Height.toInt()}',
                        onChanged: (value) {
                          designController.pic2Height = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic2Radius,
                        title:
                            'Pic2 Radius: ${designController.pic2Radius.toInt()}',
                        onChanged: (value) {
                          designController.pic2Radius = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      NewValueSlider(
                        max: 500,
                        value: designController.pic2Border,
                        title:
                            'Pic2 Border: ${designController.pic2Border.toInt()}',
                        onChanged: (value) {
                          designController.pic2Border = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text('Hide Index'),
                            Spacer(),
                            Switch(
                              value: designController.hideIndex,
                              onChanged: (value) {
                                designController.hideIndex = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text('Reverse Data'),
                            Spacer(),
                            Switch(
                              value: designController.reverseData,
                              onChanged: (value) {
                                List<dynamic> csvData =
                                    designController.csvData;
                                designController.csvData = csvData.reversed
                                    .toList();
                                designController.reverseData = value;
                                designController.update();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text('Random Data'),
                            Spacer(),
                            Switch(
                              value: designController.reverseData,
                              onChanged: (value) {
                                designController.csvData.shuffle(Random());
                                designController.update();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text('Enable Random Color'),
                            Spacer(),
                            Switch(
                              value: designController.enableRandomColor,
                              onChanged: (value) {
                                designController.enableRandomColor = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  gap(w: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ColorPickerItem(
                        hintText: 'Item Background Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.itemBackGroundColor,
                            onChange: (color) {
                              designController.itemBackGroundColor = color;
                            },
                          );
                        },
                        currentColor: designController.itemBackGroundColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Name Container Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.nameContainerColor,
                            onChange: (color) {
                              designController.nameContainerColor = color;
                            },
                          );
                        },
                        currentColor: designController.nameContainerColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Name Font Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.nameFontColor,
                            onChange: (color) {
                              designController.nameFontColor = color;
                            },
                          );
                        },
                        currentColor: designController.nameFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Large Text Container',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.LargeTextContainer,
                            onChange: (color) {
                              designController.LargeTextContainer = color;
                            },
                          );
                        },
                        currentColor: designController.LargeTextContainer,
                      ),
                      ColorPickerItem(
                        hintText: 'Large Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.largeFontColor,
                            onChange: (color) {
                              designController.largeFontColor = color;
                            },
                          );
                        },
                        currentColor: designController.largeFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Small Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.smallFontColor,
                            onChange: (color) {
                              designController.smallFontColor = color;
                            },
                          );
                        },
                        currentColor: designController.smallFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Index Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.indexFontColor,
                            onChange: (color) {
                              designController.indexFontColor = color;
                            },
                          );
                        },
                        currentColor: designController.indexFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Index Text Container',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.indexContainerColor,
                            onChange: (color) {
                              designController.indexContainerColor = color;
                            },
                          );
                        },
                        currentColor: designController.indexContainerColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Pic1 Bg Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.picBackgroundColor,
                            onChange: (color) {
                              designController.picBackgroundColor = color;
                            },
                          );
                        },
                        currentColor: designController.picBackgroundColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Pic1 Border Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.pic1BorderColor,
                            onChange: (color) {
                              designController.pic1BorderColor = color;
                            },
                          );
                        },
                        currentColor: designController.pic1BorderColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Pic2 Border Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.pic2BorderColor,
                            onChange: (color) {
                              designController.pic2BorderColor = color;
                            },
                          );
                        },
                        currentColor: designController.pic2BorderColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Pic2 Container Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.pic2ContainerColor,
                            onChange: (color) {
                              designController.pic2ContainerColor = color;
                            },
                          );
                        },
                        currentColor: designController.pic2ContainerColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Animation Container Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor:
                                designController.animationContainerColor,
                            onChange: (color) {
                              designController.animationContainerColor = color;
                            },
                          );
                        },
                        currentColor: designController.animationContainerColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (videoTimer.text.isNotEmpty) {
                  designController.videoDuration = int.parse(
                    videoTimer.text.toString().trim(),
                  );
                }
                _Key.currentState!.closeDrawer();
                designController.updateFlow();
                setState(() {});
              },
              child: Container(
                padding: spacing(h: 15, v: 7),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: borderRadius(10),
                ),
                child: Text(
                  'Generate',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            gap(h: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tableItems('index'),
                tableItems('name'),
                tableItems('pic1'),
                tableItems('pic2'),
                tableItems('smallText'),
                tableItems('largeText'),
                tableItems('icon'),
              ],
            ),
            gap(h: 60),
          ],
        ),
      ),
    );
  }

  colorPicker({
    required Color currentColor,
    required Function(Color) onChange,
  }) {
    // create some values

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onChange,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
