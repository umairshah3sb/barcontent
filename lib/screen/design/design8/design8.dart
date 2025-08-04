import 'dart:async';

import 'package:barcontent/screen/design/Design8/widgets/Design8_item.dart';
import 'package:barcontent/screen/design/design8/controller/design8_controller.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gradient_picker/flutter_gradient_picker.dart';

class Design8 extends StatefulWidget {
  const Design8({super.key});

  @override
  State<Design8> createState() => _Design8State();
}

class _Design8State extends State<Design8> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design8Controller designController = Get.put(Design8Controller());
  TextEditingController videoTimer = TextEditingController();
  double containerSize = 360;
  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _offset += details.delta;
                    });
                  },
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(
                        3,
                        2,
                        0.0001,
                      )
                      ..rotateX((_offset.dy * pi) / 180)
                      ..rotateY((_offset.dx * pi) / 180),
                    alignment: Alignment.center,
                    child: Cube3D(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Cube3D() {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001)
            ..translate(0.0, 0.0, -150),

          // Push it out so center of cube is visible
          child: Container(
            width: 300,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: borderRadius(12),
            ),
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001)
            ..translate(
                0.0, 0.0, 150.0), // Push it out so center of cube is visible
          child: Container(
            width: 300,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: borderRadius(12),
            ),
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // 🔥 Add perspective
            ..translate(150.0, 0.0, 0.0)
            ..rotateY(-pi / 2), // Rotate around Y axis
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: borderRadius(12),
            ),
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // 🔥 Add perspective
            ..translate(-150.0, 0.0, 0.0)
            ..rotateY(-pi / 2), // Rotate around Y axis
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: borderRadius(12),
            ),
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // 🔥 Add perspective
            ..translate(0.0, -150.0, 0.0)
            ..rotateX(pi / 2), // Rotate around Y axis
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: borderRadius(12),
            ),
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001) // 🔥 Add perspective
            ..translate(0.0, 450.0, 0.0)
            ..rotateX(-pi / 2), // Rotate around Y axis
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: borderRadius(12),
            ),
            child: Center(
              child: FlutterLogo(
                size: 120,
              ),
            ),
          ),
        ),
      ],
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
                  width: 300,
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title'),
                        gap(h: 5),
                        Container(
                          width: 300,
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
                            controller: designController.title,
                            onChanged: (x) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Title',
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
                    gap(w: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Background Image'),
                        gap(h: 5),
                        Container(
                          width: 300,
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
                            controller: designController.backgroundImage,
                            onChanged: (v) {
                              designController.update();
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter background Image Url',
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
                  ],
                ),
                gap(h: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name1'),
                        gap(h: 5),
                        Container(
                          width: 300,
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
                            controller: designController.name1,
                            onChanged: (x) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Name',
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
                    gap(w: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Logo1'),
                        gap(h: 5),
                        Container(
                          width: 300,
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
                      ],
                    ),
                  ],
                ),
                gap(h: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name2'),
                        gap(h: 5),
                        Container(
                          width: 300,
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
                            controller: designController.name2,
                            onChanged: (x) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Name2',
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
                    gap(w: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Logo2'),
                        gap(h: 5),
                        Container(
                          width: 300,
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
                  ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                        hintText: 'Title Font Size',
                        fontSize: designController.titleFontSize.toInt(),
                        increase: () {
                          designController.titleFontSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.titleFontSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Title Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.titleFontColor,
                            onChange: (color) {
                              designController.titleFontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.titleFontColor,
                      ),
                    ],
                  ),
                  gap(w: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      FontSizer(
                        hintText: 'Country Name Font Size',
                        fontSize: designController.countryNameFontSize.toInt(),
                        increase: () {
                          designController.countryNameFontSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.countryNameFontSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Country Name Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.countryNameFontColor,
                            onChange: (color) {
                              designController.countryNameFontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.countryNameFontColor,
                      ),
                      Container(
                        width: Get.width * 0.2,
                        margin: spacing(v: 7),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Background Gradient:'),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    designController.showBackgroundGradient =
                                        !designController
                                            .showBackgroundGradient;
                                    designController.update();
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      gradient:
                                          designController.backgroundGradient,
                                      borderRadius: borderRadius(25),
                                      boxShadow: shadow,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            gap(h: 10),
                            designController.showBackgroundGradient
                                ? Container(
                                    width: Get.width * 0.2,
                                    child: FlutterGradientPicker(
                                      onGradientChanged: (gradient) {
                                        designController.backgroundGradient =
                                            gradient;
                                        designController.update();
                                        setState(() {});
                                      },
                                    ),
                                  )
                                : gap(),
                          ],
                        ),
                      ),
                      FontSizer(
                        hintText: 'Background Image Opacity',
                        fontSize:
                            designController.backgroundImageOpacity.toInt(),
                        increase: () {
                          if (designController.backgroundImageOpacity <= 10) {
                            print(
                                'Increaseing  ${designController.backgroundImageOpacity / 10}');
                            designController.backgroundImageOpacity++;
                            designController.update();
                            setState(() {});
                          }
                        },
                        decrease: () {
                          if (designController.backgroundImageOpacity >= 0) {
                            print(
                                'Descreasing ${designController.backgroundImageOpacity / 10}');
                            designController.backgroundImageOpacity--;
                            designController.update();
                            setState(() {});
                          }
                        },
                      ),
                      FontSizer(
                        hintText: 'Text Shadow Opacity',
                        fontSize: designController.textShadowOpacity.toInt(),
                        increase: () {
                          if (designController.textShadowOpacity <= 10) {
                            print(
                                'Increaseing  ${designController.textShadowOpacity / 10}');
                            designController.textShadowOpacity++;
                            designController.update();
                            setState(() {});
                          }
                        },
                        decrease: () {
                          if (designController.textShadowOpacity >= 0) {
                            print(
                                'Descreasing ${designController.textShadowOpacity / 10}');
                            designController.textShadowOpacity--;
                            designController.update();
                            setState(() {});
                          }
                        },
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
