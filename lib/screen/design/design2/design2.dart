import 'dart:async';
import 'dart:typed_data';

import 'package:auto_scroll_row/auto_scroll_row.dart';
import 'package:auto_scroll_slider/auto_scroll_slider.dart';
import 'package:barcontent/screen/design/design1/controller/design1_controller.dart';
import 'package:barcontent/screen/design/design2/controller/design2_controller.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';
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
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: GetBuilder<design2Controller>(builder: (controller) {
        return Stack(
          children: [
            SizedBox(
              key: Key(getRandomString(20)),
              width: Get.width,
              height: Get.height,
              child: Center(
                child: AutoScrollRow(
                  reverse: false,
                  enableUserScroll: false,
                  scrollDuration: Duration(
                    seconds: controller.videoDuration,
                  ),
                  children: List.generate((controller.csvData.length + 2), (i) {
                    if (i == 0 || i == (controller.csvData.length + 1)) {
                      return designController.isGenerating
                          ? Container(
                              width: Get.width * 1.5,
                            )
                          : gap();
                    }
                    // return Container(
                    //   width: width,
                    //   margin: spacing(h: 5, v: 7),
                    //   color: darkBlue,
                    //   child: Center(
                    //     child: Text(
                    //       i.toString(),
                    //       style: GoogleFonts.manrope(
                    //         fontSize: 14,
                    //         color: whiteColor,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ),
                    // );

                    return controller.csvData[(i - 1)]['index']
                            .toString()
                            .isNotEmpty
                        ? dataWidget(
                            controller.csvData[(i - 1)],
                            designController.itemsPerScreen,
                          )
                        : gap();
                  }),
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
                        child: Icon(
                          Icons.menu,
                          color: halfBlack,
                          size: 25,
                        ),
                      ),
                    ),
                  )
          ],
        );
      }),
    );
  }

  Widget dataWidget(Map<String, dynamic> data, int itemsPerScreen) {
    double width =
        ((MediaQuery.of(context).size.width * (1 / itemsPerScreen)) - 8);
    return Container(
      key: Key(getRandomString(20)),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: shadow,
      ),
      child: ClipRRect(
        borderRadius: radiusOnly(
          topLeft: 30,
          topRight: 15,
          bottomLeft: 15,
          bottomRight: 15,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Container(
                    width: width,
                    height: Get.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: data['pic1'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: designController.indexContainerColor,
                      borderRadius: borderRadius(50),
                      boxShadow: shadow,
                    ),
                    child: Center(
                      child: Text(
                        '${data['index']}',
                        style: GoogleFonts.manrope(
                          color: designController.indexFontColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 2),
            Container(
              width: width,
              height: Get.height * 0.1,
              padding: spacing(h: 10),
              decoration: BoxDecoration(
                color: designController.nameContainerColor,
                boxShadow: shadow,
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    data['name'].toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      color: designController.nameFontColor,
                      fontSize: designController.nameFontSize.toDouble(),
                      fontWeight: FontWeight.w900,
                      shadows: [
                        Shadow(
                          color: Color(0x26442A7C),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                        Shadow(
                          color: Color(0x26442A7C),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),
            Container(
              width: width,
              height: Get.height * 0.1,
              decoration: BoxDecoration(
                color: designController.LargeTextContainer,
                boxShadow: shadow,
              ),
              child: FittedBox(
                  child: Container(
                margin: spaceOnly(top: 40),
                child: Text.rich(
                  TextSpan(
                    text: data['largeText'].toString(),
                    style: GoogleFonts.manrope(
                      color: designController.largeFontColor,
                      fontWeight: FontWeight.w900,
                      fontSize: designController.largTextSize,
                      height: -0.9,
                    ),
                    children: [
                      TextSpan(
                        text: data['smallText'],
                        style: GoogleFonts.manrope(
                          color: designController.smallFontColor,
                          height: -1,
                          fontWeight: FontWeight.w900,
                          fontSize: designController.smallTextSize,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
            Expanded(
              child: Container(
                width: width,
                child: CachedNetworkImage(
                  imageUrl: data['pic2'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
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
                    borderRadius: borderRadius(
                      10,
                    )),
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
            Container(
              width: 400,
              height: 50,
              padding: spacing(
                h: 14,
              ),
              decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: shadow,
                  borderRadius: borderRadius(50),
                  border: Border.all(
                    width: 2,
                    color: halfBlack,
                  )),
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
              padding: spacing(h: 15, v: 15),
              margin: spacing(v: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(
                  width: 2,
                  color: halfBlack,
                ),
                borderRadius: borderRadius(60),
                boxShadow: shadow,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FontSizer(
                        hintText: 'Items per screen',
                        fontSize: designController.itemsPerScreen,
                        increase: () {
                          designController.itemsPerScreen++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.itemsPerScreen--;
                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Name Font size',
                        fontSize: designController.nameFontSize.toInt(),
                        increase: () {
                          designController.nameFontSize++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.nameFontSize--;
                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Large Text Font Size',
                        fontSize: designController.largTextSize.toInt(),
                        increase: () {
                          designController.largTextSize++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.largTextSize--;
                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Small Text Font Size',
                        fontSize: designController.smallTextSize.toInt(),
                        increase: () {
                          designController.smallTextSize++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.smallTextSize--;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  gap(w: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                designController.isGenerating = true;
                designController.videoDuration =
                    int.parse(videoTimer.text.toString().trim());
                designController.updateFlow();
                _Key.currentState!.closeDrawer();
                setState(() {});
              },
              child: Container(
                padding: spacing(h: 15, v: 7),
                decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: borderRadius(
                      10,
                    )),
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

  colorPicker(
      {required Color currentColor, required Function(Color) onChange}) {
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
