import 'dart:async';
import 'dart:typed_data';

import 'package:auto_scroll_row/auto_scroll_row.dart';
import 'package:barcontent/screen/design/design17/controller/design17_controller.dart';
import 'package:barcontent/screen/design/design17/widget/design17_item1.dart';
import 'package:barcontent/screen/design/design17/widget/design17_item2.dart';
import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/font_family_selector.dart';
import 'package:barcontent/util/helper.dart';
import 'package:barcontent/util/meta_data_helper.dart';
import 'package:barcontent/util/tools/shadow_generator.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:text_style_editor/text_style_editor.dart';

class Design17 extends StatefulWidget {
  const Design17({super.key});

  @override
  State<Design17> createState() => _Design17State();
}

class _Design17State extends State<Design17> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design17Controller designController = Get.put(Design17Controller());
  TextEditingController videoTimer = TextEditingController();
  TextEditingController backgroundImage = TextEditingController();

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: GetBuilder<Design17Controller>(builder: (controller) {
        return Stack(
          children: [
            Container(
              key: Key(getRandomString(20)),
              width: Get.width,
              height: Get.height,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: designController.backgroundColor,
                    border: Border.all(width: 2),
                    image: backgroundImage.text.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(backgroundImage.text),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: AspectRatio(
                    aspectRatio: designController.aspectRatio,
                    child: controller.isGenerating
                        ? controller.isAnimate
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.animatedItem,
                                ),
                              )
                            : AutoScrollRow(
                                reverse: false,
                                enableUserScroll: false,
                                scrollDuration: Duration(
                                  seconds: controller.videoDuration,
                                ),
                                children: List.generate(
                                    ((controller.csvData.length + 1)), (i) {
                                  if (i == controller.csvData.length) {
                                    return Container(
                                      width: Get.width * 1.5,
                                    );
                                  }
                                  return controller.csvData[(i)]['index']
                                          .toString()
                                          .isNotEmpty
                                      ? designController.template == 0
                                          ? Design17Item1(
                                              data: controller.csvData[(i)],
                                              index: i,
                                            )
                                          : Design17Item2(
                                              data: controller.csvData[(i)],
                                              index: i,
                                            )
                                      : gap();
                                }),
                              )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  (controller.csvData.length), (i) {
                                return controller.csvData[(i)]['index']
                                        .toString()
                                        .isNotEmpty
                                    ? designController.template == 0
                                        ? Design17Item1(
                                            data: controller.csvData[(i)],
                                            index: i,
                                          )
                                        : Design17Item2(
                                            data: controller.csvData[(i)],
                                            index: i,
                                          )
                                    : gap();
                              }),
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
                  )
          ],
        );
      }),
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
                  ),
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
                border: Border.all(
                  width: 2,
                  color: halfBlack,
                ),
                borderRadius: borderRadius(60),
                boxShadow: shadow,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Aspect Ratio',
                      ),
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
                                child: Text(
                                  '3/4',
                                  textAlign: TextAlign.center,
                                ),
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
                                child: Text(
                                  '4/3',
                                  textAlign: TextAlign.center,
                                ),
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
                                child: Text(
                                  '1/1',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      gap(h: 10),
                      Wrap(
                        children: [
                          InkWell(
                            onTap: () {
                              designController.template = 0;
                              designController.update();
                              setState(() {});
                            },
                            child: Container(
                              padding: spacing(h: 10, v: 5),
                              margin: spacing(h: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: designController.template == 0
                                      ? Colors.blue
                                      : halfBlack,
                                ),
                                boxShadow: shadow,
                                borderRadius: borderRadius(10),
                              ),
                              child: Text('Template 1'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              designController.template = 1;
                              designController.update();
                              setState(() {});
                            },
                            child: Container(
                              padding: spacing(h: 10, v: 5),
                              margin: spacing(h: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: designController.template == 1
                                      ? Colors.blue
                                      : halfBlack,
                                ),
                                boxShadow: shadow,
                                borderRadius: borderRadius(10),
                              ),
                              child: Text('Template 2'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              designController.template = 2;

                              designController.update();
                              setState(() {});
                            },
                            child: Container(
                              padding: spacing(h: 10, v: 5),
                              margin: spacing(h: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: designController.template == 2
                                      ? Colors.blue
                                      : halfBlack,
                                ),
                                boxShadow: shadow,
                                borderRadius: borderRadius(10),
                              ),
                              child: Text('Template 3'),
                            ),
                          ),
                        ],
                      ),
                      ValueChangeSlider(
                        max: 2000,
                        value: designController.itemsWidth,
                        title:
                            'Item Width: ${designController.itemsWidth.toInt()}',
                        onChanged: (value) {
                          designController.itemsWidth = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.itemsWidth++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.itemsWidth--;
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
                      FontSizer(
                        hintText: 'Animation items',
                        fontSize: designController.initialItems.toInt(),
                        increase: () {
                          designController.initialItems++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.initialItems--;
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
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
                      ValueChangeSlider(
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
                      ValueChangeSlider(
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
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.nameStyle,
                          textAlign: designController.nameTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.nameTextAlign = align;
                            });
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.nameStyle = style;
                            });
                            designController.update();
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
                      ShadowGeneratorScreen(
                        text: 'Pic shadow',
                        onApply: (shadow) {
                          designController.picShadow = shadow;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
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
                      ValueChangeSlider(
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
                      ValueChangeSlider(
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
                      ValueChangeSlider(
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
                      ValueChangeSlider(
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
                      designController.template == 0
                          ? gap()
                          : Column(
                              children: [
                                ValueChangeSlider(
                                  max: 500,
                                  value:
                                      designController.diamondContainerHeight,
                                  title:
                                      'Diamond Container Height: ${designController.diamondContainerHeight.toInt()}',
                                  onChanged: (value) {
                                    designController.diamondContainerHeight =
                                        value;
                                    designController.update();
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 500,
                                  value: designController.diamondWidth,
                                  title:
                                      'Diamond Width: ${designController.diamondWidth.toInt()}',
                                  onChanged: (value) {
                                    designController.diamondWidth = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 500,
                                  value: designController.diamondHeight,
                                  title:
                                      'Diamond Height: ${designController.diamondHeight.toInt()}',
                                  onChanged: (value) {
                                    designController.diamondHeight = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 500,
                                  value: designController.diamondRadius,
                                  title:
                                      'Diamond Radius: ${designController.diamondRadius.toInt()}',
                                  onChanged: (value) {
                                    designController.diamondRadius = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 500,
                                  value: designController.diamondBorder,
                                  title:
                                      'Diamond Border: ${designController.diamondBorder.toInt()}',
                                  onChanged: (value) {
                                    designController.diamondBorder = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                       Column(
                              children: [
                                ShadowGeneratorScreen(
                                  text: 'Icon shadow',
                                  onApply: (shadow) {
                                    designController.iconShadow = shadow;
                                    designController.update();
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 1000,
                                  value: designController.iconSize,
                                  title:
                                      'Icon Size: ${designController.iconSize.toInt()}',
                                  onChanged: (value) {
                                    designController.iconSize = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                  increase: () {
                                    designController.iconSize++;
                                    setState(() {});
                                  },
                                  decrease: () {
                                    designController.iconSize--;
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 1000,
                                  value: designController.iconRadius,
                                  title:
                                      'Icon Radius: ${designController.iconRadius.toInt()}',
                                  onChanged: (value) {
                                    designController.iconRadius = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                  increase: () {
                                    designController.iconRadius++;
                                    setState(() {});
                                  },
                                  decrease: () {
                                    designController.iconRadius--;
                                    setState(() {});
                                  },
                                ),
                                ValueChangeSlider(
                                  max: 200,
                                  value: designController.iconSpace,
                                  title:
                                      'Icon bottom Space: ${designController.iconSpace.toInt()}',
                                  onChanged: (value) {
                                    designController.iconSpace = value;
                                    designController.update();
                                    setState(() {});
                                  },
                                  increase: () {
                                    designController.iconSpace++;
                                    setState(() {});
                                  },
                                  decrease: () {
                                    designController.iconSpace--;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Hide Index',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.hideIndex,
                              onChanged: (value) {
                                designController.hideIndex = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Diamond Pic',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.diamondPic,
                              onChanged: (value) {
                                designController.diamondPic = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Tagline Gradient',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.taglineGradient,
                              onChanged: (value) {
                                designController.taglineGradient = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Name Gradient',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.nameGradient,
                              onChanged: (value) {
                                designController.nameGradient = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Enable Random Color',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.enableRandomColor,
                              onChanged: (value) {
                                designController.enableRandomColor = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Enable Tagline',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.enableTagline,
                              onChanged: (value) {
                                designController.enableTagline = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Reverse Data',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.reverseData,
                              onChanged: (value) {
                                List<dynamic> csvData =
                                    designController.csvData;
                                designController.csvData =
                                    csvData.reversed.toList();
                                designController.reverseData = value;
                                designController.update();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Random Data',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.randomData,
                              onChanged: (value) {
                                designController.csvData.shuffle(Random());
                                designController.update();
                                setState(() {});
                              },
                            )
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
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.taglineStyle,
                          textAlign: designController.tagTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.tagTextAlign = align;
                            });
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.taglineStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontFamilyDropdown(
                        text: 'Tagline Font Family',
                        onFontSelected: (font) {
                          designController.taglineFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        max: 300,
                        value: designController.taglineContainerHeight,
                        title:
                            'Tagline Container Height: ${designController.taglineContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.taglineContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                        increase: () {
                          designController.taglineContainerHeight++;
                          setState(() {});
                        },
                        decrease: () {
                          designController.taglineContainerHeight--;
                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Tagline Container Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.taglineTextContainer,
                            onChange: (color) {
                              designController.taglineTextContainer = color;
                            },
                          );
                        },
                        currentColor: designController.taglineTextContainer,
                      ),
                      ColorPickerItem(
                        hintText: 'Tagline Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.taglineFontColor,
                            onChange: (color) {
                              designController.taglineFontColor = color;
                            },
                          );
                        },
                        currentColor: designController.taglineFontColor,
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
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.largeStyle,
                          textAlign: designController.largeTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.largeTextAlign = align;
                            });
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.largeStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontFamilyDropdown(
                        text: 'largeText Font Family',
                        onFontSelected: (font) {
                          designController.largeFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
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
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.smallStyle,
                          textAlign: designController.smallTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.smallTextAlign = align;
                            });
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.smallStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontFamilyDropdown(
                        text: 'SmallText Font Family',
                        onFontSelected: (font) {
                          designController.smallFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
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
                        hintText: 'Diamond Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: diamondColor,
                            onChange: (color) {
                              diamondColor = color;
                              diamondColorWithShade = darken(color, 0.1);
                            },
                          );
                        },
                        currentColor: diamondColor,
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
                        hintText: designController.template == 0
                            ? 'Bottom Container Color'
                            : 'Diamond Bg Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.bottomContainerColor,
                            onChange: (color) {
                              designController.bottomContainerColor = color;
                            },
                          );
                        },
                        currentColor: designController.bottomContainerColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Background Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.backgroundColor,
                            onChange: (color) {
                              designController.backgroundColor = color;
                            },
                          );
                        },
                        currentColor: designController.backgroundColor,
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
                  designController.videoDuration =
                      int.parse(videoTimer.text.toString().trim());
                }
                _Key.currentState!.closeDrawer();
                setState(() {});

                designController.updateFlow();
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
                tableItems('pic'),
                tableItems('name'),
                tableItems('tagline'),
                tableItems('largeText'),
                tableItems('smallText'),
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
