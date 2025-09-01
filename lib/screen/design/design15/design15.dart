import 'dart:async';
import 'package:barcontent/screen/design/design15/controller/design15_controller.dart';
import 'package:barcontent/screen/design/design15/widgets/design15_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/font_family_selector.dart';
import 'package:barcontent/util/helper.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gradient_picker/flutter_gradient_picker.dart';

class Design15 extends StatefulWidget {
  const Design15({super.key});

  @override
  State<Design15> createState() => _Design15State();
}

class _Design15State extends State<Design15> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design15Controller designController = Get.put(Design15Controller());
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
      body: GetBuilder<Design15Controller>(builder: (controller) {
        return Stack(
          children: [
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: controller.aspectRatio,
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
              bottom: 0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: controller.aspectRatio,
                  child: Container(
                    width: containerSize, // You can change this value
                    height: Get.height,
                    padding: spacing(h: controller.VideoContainerSpacingH),
                    child: Column(
                      children: [
                        gap(h: 10),
                        Container(
                          alignment: Alignment.center,
                          margin: spacing(v: 10),
                          padding: spacing(h: 15),
                          child: Text(
                            controller.title.text,
                            style: GoogleFonts.getFont(
                              controller.titleFontFamily,
                              fontWeight: FontWeight.bold,
                              color: controller.titleFontColor,
                              fontSize: controller.titleFontSize,
                              shadows: [
                                Shadow(
                                  color: controller.shadowColor.withAlpha(
                                    (255 * (controller.textShadowOpacity / 10))
                                        .toInt(),
                                  ),
                                  offset: Offset.zero,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        Design15MainUI(
                          itemData: controller.csvData.isEmpty
                              ? controller.dumyData
                              : controller.csvData[controller.currentIndex],
                          key: Key(getRandomString(20)),
                        ),
                        gap(h: 20),
                      ],
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
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Animation Gap'),
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
                        Text('Verse Image'),
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
                            controller: designController.verserImage,
                            onChanged: (x) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter verse Image Url',
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
                      ValueChangeSlider(
                        value: designController.VideoContainerSpacingH,
                        max: 150,
                        title:
                            'Video Container Horizatal Padding: ${designController.VideoContainerSpacingH.toInt()}',
                        onChanged: (value) {
                          designController.VideoContainerSpacingH = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.VideoContainerHeight,
                        max: 1200,
                        title:
                            'Video Container Height: ${designController.VideoContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.VideoContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picContainerWidth,
                        max: 1000,
                        title:
                            'Flag Container Width: ${designController.picContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.picContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picContainerHeight,
                        max: 1000,
                        title:
                            'Flag Container Height: ${designController.picContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.picContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picHMargin,
                        max: 200,
                        title:
                            'Pic Horizontal Margin: ${designController.picHMargin.toInt()}',
                        onChanged: (value) {
                          designController.picHMargin = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picVMargin,
                        max: 200,
                        title:
                            'Pic Vertical Margin: ${designController.picVMargin.toInt()}',
                        onChanged: (value) {
                          designController.picVMargin = value;
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
                      ValueChangeSlider(
                        value: designController.vsImageWidth,
                        max: 300,
                        title:
                            'Vs Image width: ${designController.vsImageWidth.toInt()}',
                        onChanged: (value) {
                          designController.vsImageWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      FontFamilyDropdown(
                        text: 'Title Font Family',
                        onFontSelected: (font) {
                          designController.titleFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.titleFontSize,
                        max: 200,
                        title:
                            'Title Font Size: ${designController.titleFontSize.toInt()}',
                        onChanged: (value) {
                          designController.titleFontSize = value;
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
                      Container(
                        width: Get.width * 0.2,
                        child: Row(
                          children: [
                            Text(
                              'Differen Pic',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.differencePic,
                              onChanged: (value) {
                                designController.differencePic = value;
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
                              'Change Style',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.changeStyle,
                              onChanged: (value) {
                                designController.changeStyle = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  gap(w: 40),
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
                      FontFamilyDropdown(
                        text: 'Name Font Family',
                        onFontSelected: (font) {
                          designController.nameFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.nameTextSize,
                        max: 200,
                        title:
                            'Name Font Size: ${designController.nameTextSize.toInt()}',
                        onChanged: (value) {
                          designController.nameTextSize = value;
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
                      ValueChangeSlider(
                        value: designController.valueWidth,
                        max: 1200,
                        title:
                            'Value Width: ${designController.valueWidth.toInt()}',
                        onChanged: (value) {
                          designController.valueWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      FontFamilyDropdown(
                        text: 'Value Font Family',
                        onFontSelected: (font) {
                          designController.valueFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.valueFontSize,
                        max: 200,
                        title:
                            'Value Text Font Size: ${designController.valueFontSize.toInt()}',
                        onChanged: (value) {
                          designController.valueFontSize = value;
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
                      FontFamilyDropdown(
                        text: 'Country Font Family',
                        onFontSelected: (font) {
                          designController.countryFontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.countryNameFontSize,
                        max: 200,
                        title:
                            'Country Font Size: ${designController.countryNameFontSize.toInt()}',
                        onChanged: (value) {
                          designController.countryNameFontSize = value;
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
                      ColorPickerItem(
                        hintText: 'Text Shadow Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.shadowColor,
                            onChange: (color) {
                              designController.shadowColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.shadowColor,
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
                      ColorPickerItem(
                        hintText: 'Flag Shadow Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.flagShadowColor,
                            onChange: (color) {
                              designController.flagShadowColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.flagShadowColor,
                      ),
                      FontSizer(
                        hintText: 'Flag Shadow Opacity',
                        fontSize: designController.flagShadowOpacity.toInt(),
                        increase: () {
                          if (designController.flagShadowOpacity <= 10) {
                            print(
                                'Increaseing  ${designController.flagShadowOpacity / 10}');
                            designController.flagShadowOpacity++;
                            designController.update();
                            setState(() {});
                          }
                        },
                        decrease: () {
                          if (designController.flagShadowOpacity >= 0) {
                            print(
                                'Descreasing ${designController.flagShadowOpacity / 10}');
                            designController.flagShadowOpacity--;
                            designController.update();
                            setState(() {});
                          }
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Pic Border Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.picBorderColor,
                            onChange: (color) {
                              designController.picBorderColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.picBorderColor,
                      ),
                      FontSizer(
                        hintText: 'Pic border Size',
                        fontSize: designController.picBorderSize.toInt(),
                        increase: () {
                          print(
                              'Increaseing  ${designController.picBorderSize / 10}');
                          designController.picBorderSize++;
                          designController.update();
                          setState(() {});
                        },
                        decrease: () {
                          print(
                              'Descreasing ${designController.picBorderSize / 10}');
                          designController.picBorderSize--;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Flag Border Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.flagBorderColor,
                            onChange: (color) {
                              designController.flagBorderColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.flagBorderColor,
                      ),
                      FontSizer(
                        hintText: 'Flag Border Size',
                        fontSize: designController.flagBorderSize.toInt(),
                        increase: () {
                          print(
                              'Increaseing  ${designController.flagBorderSize / 10}');
                          designController.flagBorderSize++;
                          designController.update();
                          setState(() {});
                        },
                        decrease: () {
                          print(
                              'Descreasing ${designController.flagBorderSize / 10}');
                          designController.flagBorderSize--;
                          designController.update();
                          setState(() {});
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
                tableItems('name'),
                tableItems('pic'),
                tableItems('pic1'),
                tableItems('pic2'),
                tableItems('value1'),
                tableItems('value2'),
              ],
            ),
            gap(h: 30),
            Text(
                '*  When you turn on difference pic button then you much have pic1 and pic2 value, pic can be empty in that case'),
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
