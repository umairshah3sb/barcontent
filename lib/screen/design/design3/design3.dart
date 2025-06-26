import 'dart:async';
import 'package:auto_scroll_row/auto_scroll_row.dart';
import 'package:barcontent/screen/design/design3/controller/design3_controller.dart';
import 'package:barcontent/screen/design/design3/widgets/design3_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Design3 extends StatefulWidget {
  const Design3({super.key});

  @override
  State<Design3> createState() => _Design3State();
}

class _Design3State extends State<Design3> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final design3Controller designController = Get.put(design3Controller());
  TextEditingController videoTimer = TextEditingController();
  double containerSize = 360;
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      maxScroll,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Always dispose the controller!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: GetBuilder<design3Controller>(builder: (controller) {
        return Stack(
          children: [
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    width: containerSize, // You can change this value
                    decoration: BoxDecoration(
                      color: controller.backgroundColor,
                    ),
                    child: Container(
                      height: Get.height,
                      child: Column(
                        children: [
                          Container(
                            color: greyColor,
                            height: designController.logoSize,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FlagSection(
                                    designController.logo1.text,
                                  ),
                                ),
                                Expanded(
                                  child:
                                      FlagSection(designController.logo2.text),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              child: Column(
                                children: controller.itemsList,
                              ),
                            ),
                          )
                        ],
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
                        child: Icon(
                          Icons.menu,
                          color: halfBlack,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
            Positioned(
              top: 100,
              left: 15,
              child: InkWell(
                onTap: () {
                  _scrollToBottom();
                  setState(() {});
                },
                child: Container(
                  padding: spacing(h: 7, v: 7),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: borderRadius(50),
                  ),
                  child: Icon(
                    Icons.arrow_downward,
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

  Widget FlagSection(String image) {
    return Container(
      margin: spacing(h: 10, v: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius(designController.logoRadius),
        boxShadow: [
          BoxShadow(
            color: Color(0x26442A7C),
            blurRadius: 28.68,
            offset: Offset(0, 28.68),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x26442A7C),
            blurRadius: 28.68,
            offset: Offset(0, 28.68),
            spreadRadius: 0,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius(designController.logoRadius),
        child: CachedNetworkImage(
          imageUrl: image.isNotEmpty
              ? image
              : 'https://t4.ftcdn.net/jpg/02/44/43/69/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg',
          fit: BoxFit.cover,
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
          designController.csvData = dataAsMap;
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      hintText: 'Enter Animation Gap',
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
                gap(h: 10),
                Text('Logo1'),
                gap(h: 5),
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
                    controller: designController.logo1,
                    onChanged: (x) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter First Image Url',
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
                gap(h: 10),
                Text('Logo2'),
                gap(h: 5),
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
                    controller: designController.logo2,
                    onChanged: (x) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter 2nd Image Url',
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
                        hintText: 'Logo Radius',
                        fontSize: designController.logoRadius.toInt(),
                        increase: () {
                          designController.logoRadius++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.logoRadius--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Logo Size',
                        fontSize: designController.logoSize.toInt(),
                        increase: () {
                          designController.logoSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.logoSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Value Text Font Size',
                        fontSize: designController.valueFontSize.toInt(),
                        increase: () {
                          designController.valueFontSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.valueFontSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Data Container Size',
                        fontSize: designController.valueContainerSize.toInt(),
                        increase: () {
                          designController.valueContainerSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Data Container Spacing',
                        fontSize: designController.dataContainerSpacing.toInt(),
                        increase: () {
                          designController.dataContainerSpacing++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.dataContainerSpacing--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Data Container Height',
                        fontSize: designController.dataContainerHeight.toInt(),
                        increase: () {
                          designController.dataContainerHeight++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.dataContainerHeight--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Data Container Width',
                        fontSize: designController.dataContainerWidth.toInt(),
                        increase: () {
                          designController.dataContainerWidth++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.dataContainerWidth--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Pic Contaner Size',
                        fontSize: designController.picContainerSize.toInt(),
                        increase: () {
                          designController.picContainerSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.picContainerSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Pic Container Radius',
                        fontSize: designController.picContainerRadius.toInt(),
                        increase: () {
                          designController.picContainerRadius++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.picContainerRadius--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Name Text Font Size',
                        fontSize: designController.nameTextSize.toInt(),
                        increase: () {
                          designController.nameTextSize++;
                          designController.update();
                          setState(() {});
                        },
                        decrease: () {
                          designController.nameTextSize--;
                          designController.update();
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
                        hintText: 'Name Font Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.nameFontColor,
                            onChange: (color) {
                              designController.nameFontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.nameFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Container Animation Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor:
                                designController.valueContainerAnimation,
                            onChange: (color) {
                              designController.valueContainerAnimation = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueContainerAnimation,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Container Left Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueContainerLeft,
                            onChange: (color) {
                              designController.valueContainerLeft = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueContainerLeft,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Container Right Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueContainerRight,
                            onChange: (color) {
                              designController.valueContainerRight = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueContainerRight,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueFontColor,
                            onChange: (color) {
                              designController.valueFontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Title Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.smallFontColor,
                            onChange: (color) {
                              designController.smallFontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.smallFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Background Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.backgroundColor,
                            onChange: (color) {
                              designController.backgroundColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.backgroundColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                designController.isGenerating = true;
                if (videoTimer.text.toString().isNotEmpty) {
                  designController.animationGap =
                      int.parse(videoTimer.text.toString().trim());
                }
                designController.updateFlow();
                // _Key.currentState!.closeDrawer();
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
                tableItems('value1'),
                tableItems('name'),
                tableItems('pic'),
                tableItems('value2'),
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
