import 'dart:async';
import 'package:barcontent/screen/design/design19/controller/design19_controller.dart';
import 'package:barcontent/screen/design/design19/widgets/design19_bar1.dart';
import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/font_family_selector.dart';
import 'package:barcontent/util/helper.dart';
import 'package:barcontent/util/meta_data_helper.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gradient_picker/flutter_gradient_picker.dart';
import 'package:text_style_editor/text_style_editor.dart';

class Design19 extends StatefulWidget {
  const Design19({super.key});

  @override
  State<Design19> createState() => _Design19State();
}

class _Design19State extends State<Design19> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design19Controller designController = Get.put(Design19Controller());
  TextEditingController videoTimer = TextEditingController();
  double containerSize = 360;
  @override
  Widget build(BuildContext context) {
    MetaHelper.setMetaData(
      title:
          "3D Data Bar Video Maker | Free Animated Chart & Ranking Generator",
      description:
          "Create stunning 3D data bar videos online for free. Turn CSV data into animated charts, rankings, and comparison videos with smooth 3D effects—just like Blender. Perfect for visualizing growth, economy, population, sports stats, and more. No watermark, easy export for YouTube and presentations.",
      keywords:
          "3d data bar video maker, free animated chart generator, blender style bar chart race video, csv to 3d animation video, 3d ranking video creator, animated bar chart comparison video tool, data visualization video maker free, economy growth 3d bar video, population ranking 3d chart generator, free 3d data video tool no watermark",
      author: "Umair Shah",
      ogImage: '${domainUrl}assets/assets/img/Design7.png',
      ogUrl: '${domainUrl}${AppRoutes.design19VideoGenerator}',
    );
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: SafeArea(
        child: GetBuilder<Design19Controller>(builder: (controller) {
          return Stack(
            key: Key(getRandomString(30)),
            children: [
              Positioned(
                right: 50,
                top: 0,
                bottom: 15,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      height: (Get.height - 200),
                      width: containerSize, // You can change this value
                      decoration: BoxDecoration(
                        gradient: controller.backgroundGradient,
                      ),
                      child: controller.backgroundImage.text.isNotEmpty
                          ? Opacity(
                              opacity: (controller.backgroundImageOpacity / 10),
                              child: Image.network(
                                controller.backgroundImage.text,
                                fit: BoxFit.cover,
                              ),
                            )
                          : gap(),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 50,
                top: 0,
                bottom: 15,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DemoChartRow(),
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
            ],
          );
        }),
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
                gap(h: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Animation Duration'),
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
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
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
                      ValueChangeSlider(
                        max: 600,
                        value: designController.barWidth,
                        title:
                            'Bar Width: ${designController.barWidth.toInt()}',
                        onChanged: (value) {
                          designController.barWidth = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.barWidth++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.barWidth--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 600,
                        value: designController.maxValue,
                        title:
                            'Bar Max Height: ${designController.maxValue.toInt()}',
                        onChanged: (value) {
                          designController.maxValue = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.maxValue++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.maxValue--;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Bar Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.barColor,
                            onChange: (color) {
                              designController.barColor = color;
                              designController.update();
                              setState(() {});
                            },
                          );
                        },
                        currentColor: designController.barColor,
                      ),
                      ValueChangeSlider(
                        max: 300,
                        value: designController.spaceBetween,
                        title:
                            'Space Between: ${designController.spaceBetween.toInt()}',
                        onChanged: (value) {
                          designController.spaceBetween = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.spaceBetween++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.spaceBetween--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 2000,
                        value: designController.picContainerWidth,
                        title:
                            'Pic Width: ${designController.picContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.picContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.picContainerWidth++;
                          designController.update();
                          setState(() {});
                        },
                        decrease: () {
                          designController.picContainerWidth--;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 500,
                        value: designController.picBottomSpace,
                        title:
                            'Pic Bottom Space: ${designController.picBottomSpace.toInt()}',
                        onChanged: (value) {
                          designController.picBottomSpace = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.picBottomSpace++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.picBottomSpace--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 600,
                        value: designController.nameContainerWidth,
                        title:
                            'Name Container Width: ${designController.nameContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.nameContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.nameContainerWidth++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.nameContainerWidth--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 100,
                        value: designController.nameContainerPadding,
                        title:
                            'Name Container Padding: ${designController.nameContainerPadding.toInt()}',
                        onChanged: (value) {
                          designController.nameContainerPadding = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.nameContainerPadding++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.nameContainerPadding--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 100,
                        value: designController.nameContainerRadius,
                        title:
                            'Name Container Radius: ${designController.nameContainerRadius.toInt()}',
                        onChanged: (value) {
                          designController.nameContainerRadius = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.nameContainerRadius++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.nameContainerRadius--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 200,
                        value: designController.nameTopSpacing,
                        title:
                            'Name Top Spacing: ${designController.nameTopSpacing.toInt()}',
                        onChanged: (value) {
                          designController.nameTopSpacing = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.nameTopSpacing++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.nameTopSpacing--;
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
                              setState(() {});
                            },
                          );
                        },
                        currentColor: designController.nameFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Name Background Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueBGColor,
                            onChange: (color) {
                              designController.valueBGColor = color;
                              designController.update();

                              setState(() {});
                            },
                          );
                        },
                        currentColor: designController.valueBGColor,
                      ),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.nameStyle,
                          textAlign: designController.nameTextAlign,
                          onTextAlignEdited: (align) {
                            designController.nameTextAlign = align;

                            designController.update();
                            setState(() {});
                          },
                          onTextStyleEdited: (style) {
                            designController.nameStyle = style;

                            designController.update();
                            setState(() {});
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontFamilyDropdown(
                        text: 'Name Font Family',
                        onFontSelected: (font) {
                          designController.nameFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 600,
                        value: designController.valueContainerWidth,
                        title:
                            'Value Container Width: ${designController.valueContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.valueContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.valueContainerWidth++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerWidth--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 100,
                        value: designController.valueContainerPadding,
                        title:
                            'Value Container Padding: ${designController.valueContainerPadding.toInt()}',
                        onChanged: (value) {
                          designController.valueContainerPadding = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.valueContainerPadding++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerPadding--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 100,
                        value: designController.valueContainerRadius,
                        title:
                            'Value Container Radius: ${designController.valueContainerRadius.toInt()}',
                        onChanged: (value) {
                          designController.valueContainerRadius = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.valueContainerRadius++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerRadius--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 200,
                        value: designController.valueTopSpacing,
                        title:
                            'Value Top Spacing: ${designController.valueTopSpacing.toInt()}',
                        onChanged: (value) {
                          designController.valueTopSpacing = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.valueTopSpacing++;
                          designController.update();
                          setState(() {});
                        },
                        decrease: () {
                          designController.valueTopSpacing--;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Value Font Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueFontColor,
                            onChange: (color) {
                              designController.valueFontColor = color;
                              designController.update();

                              setState(() {});
                            },
                          );
                        },
                        currentColor: designController.valueFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Background Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueBGColor,
                            onChange: (color) {
                              designController.valueBGColor = color;
                              designController.update();

                              setState(() {});
                            },
                          );
                        },
                        currentColor: designController.valueBGColor,
                      ),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.valueStyle,
                          textAlign: designController.valueTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.valueTextAlign = align;
                            });
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.valueStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontFamilyDropdown(
                        text: 'Value Font Family',
                        onFontSelected: (font) {
                          designController.valueFontFamily = font;
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
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (videoTimer.text.isNotEmpty) {
                      designController.animationGap =
                          int.parse(videoTimer.text.toString().trim());
                    }
                    _Key.currentState!.closeDrawer();
                    designController.isGenerating = true;
                    designController.update();
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
                gap(w: 20),
                InkWell(
                  onTap: () {
                    designController.isGenerating =
                        !designController.isGenerating;
                    designController.update();
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
                      'Show All',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            gap(h: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tableItems('name'),
                tableItems('value'),
                tableItems('pic'),
                tableItems('prefix'),
                tableItems('percentage'),
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
