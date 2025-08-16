import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcontent/screen/design/design12/controller/design12_controller.dart';
import 'package:barcontent/screen/design/design12/widgets/image_slide.dart';
import 'package:barcontent/screen/design/design12/widgets/ribbon_design.dart';
import 'package:barcontent/screen/design/design12/widgets/text_animator.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gradient_picker/flutter_gradient_picker.dart';
import 'package:text_style_editor/text_style_editor.dart';

class Design12 extends StatefulWidget {
  const Design12({super.key});

  @override
  State<Design12> createState() => _Design12State();
}

class _Design12State extends State<Design12> {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design12Controller designController = Get.put(Design12Controller());
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
  void initState() {
    designController.title.text = 'Network';
    super.initState();
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
      body: GetBuilder<Design12Controller>(builder: (controller) {
        return Stack(
          children: [
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
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
              bottom: 0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    width: containerSize, // You can change this value
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        gap(h: controller.topSpacing),
                        Text(
                          controller.title.text,
                          style: controller.titleTextStyle.copyWith(
                            color: controller.titleFontColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DataItem(controller,
                                title: controller.name1.text,
                                image: controller.logo1.text,
                                index: 1),
                            Column(
                              children: [
                                Container(
                                  width: controller.picContainerSize,
                                  child: TextAnimator(
                                    key: Key(getRandomString(30)),
                                    delayInSeconds: 2,
                                    text: controller.csvData.isNotEmpty
                                        ? controller.csvData[
                                            controller.currentIndex]['subtitle']
                                        : controller.dumyData['name'],
                                    style:
                                        controller.subTitleTextStyle.copyWith(
                                      color: controller.subtitleFontColor,
                                    ),
                                    overflow: TextOverflow.visible,
                                    textAlign: controller.subTitleTextAlign,
                                    maxlines: 2,
                                  ),
                                ),
                                // Text(
                                //   controller.csvData.isNotEmpty
                                //       ? controller
                                //               .csvData[controller.currentIndex]
                                //           ['subtitle']
                                //       : controller.dumyData['name'],
                                //   style: controller.subTitleTextStyle.copyWith(
                                //     color: controller.subtitleFontColor,
                                //   ),
                                // ),
                                gap(h: controller.IconsSpacing),
                                Container(
                                  width: controller.picContainerSize,
                                  child: SlideImageFromBottom(
                                    seconds: 1,
                                    key: Key(getRandomString(30)),
                                    img: controller.csvData.isNotEmpty
                                        ? controller.csvData[
                                            controller.currentIndex]['icon']
                                        : controller.dumyData['icon'],
                                  ),
                                ),
                                gap(h: controller.IconPosition),
                              ],
                            ),
                            DataItem(
                              controller,
                              title: controller.name2.text,
                              image: controller.logo2.text,
                              index: 2,
                            ),
                          ],
                        ),
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

  Widget DataItem(
    Design12Controller controller, {
    String title = '',
    String image = '',
    int index = 1,
    int flagValue = 1,
  }) {
    return Container(
      width: controller.dataContainerWidth,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: controller.dataContainerHeight,
                child: CachedNetworkImage(
                  key: Key(getRandomString(20)),
                  imageUrl: image.isEmpty ? 'https://bit.ly/3GUeno8' : image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Center(
                    child: FittedBox(
                  child: Container(
                    width: controller.valueContainerSize,
                    // height: controller.dataContainerHeight,
                    alignment: Alignment.center,
                    padding: spacing(h: 10, v: 10),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? controller.valueContainerRight
                          : controller.valueContainerLeft,
                      boxShadow: [
                        BoxShadow(
                            color: controller.valueContainerShadow1,
                            spreadRadius: 0.0,
                            blurRadius: controller.valueContainerShadowRadius,
                            offset: Offset(3.0, 3.0)),
                        BoxShadow(
                            color: controller.valueContainerShadow1,
                            spreadRadius: 0.0,
                            blurRadius:
                                controller.valueContainerShadowRadius / 2.0,
                            offset: Offset(3.0, 3.0)),
                        BoxShadow(
                            color: controller.valueContainerShadow2,
                            spreadRadius: 2.0,
                            blurRadius: controller.valueContainerShadowRadius,
                            offset: Offset(-3.0, -3.0)),
                        BoxShadow(
                            color: controller.valueContainerShadow2,
                            spreadRadius: 2.0,
                            blurRadius:
                                controller.valueContainerShadowRadius / 2,
                            offset: Offset(-3.0, -3.0)),
                      ],
                      borderRadius: borderRadius(15),
                    ),
                    child: true
                        ? TextAnimator(
                            key: Key(getRandomString(30)),
                            delayInSeconds: index == 1 ? 3 : 4,
                            text: controller.csvData.isEmpty
                                ? '  ${controller.dumyData['value${index}']}  '
                                : '  ${controller.csvData[controller.currentIndex]['value${index}']}  ',
                            style: controller.valueTextStyle.copyWith(
                              color: controller.valueFontColor,
                            ),
                            textAlign: controller.valueTextAlign,
                            maxlines: 8,
                            overflow: TextOverflow.visible,
                          )
                        : AutoSizeText(
                            controller.csvData.isEmpty
                                ? '  ${controller.dumyData['value${index}']}  '
                                : '  ${controller.csvData[controller.currentIndex]['value${index}']}  ',
                            style: designController.valueTextStyle.copyWith(
                              color: controller.valueFontColor,
                            ),
                            maxLines: 8,
                            textAlign: designController.valueTextAlign,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                )),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: controller.flagPosition,
                child: controller.csvData.isNotEmpty &&
                        controller.csvData[controller.currentIndex]
                                    ['flag${index}']
                                .toString() ==
                            '2'
                    ? gap()
                    : Center(
                        child: Container(
                          width: controller.flagWidth,
                          child: SlideImageFromBottom(
                            seconds: 6,
                            key: Key(getRandomString(30)),
                            img: controller.csvData.isEmpty
                                ? index == 1
                                    ? 'https://i.postimg.cc/sD7R4R2x/image.png'
                                    : 'https://i.postimg.cc/RVcjnQPn/image.png'
                                : controller.csvData[controller.currentIndex]
                                                ['flag${index}']
                                            .toString() ==
                                        '1'
                                    ? 'https://i.postimg.cc/sD7R4R2x/image.png'
                                    : 'https://i.postimg.cc/RVcjnQPn/image.png',
                          ),
                        ),
                      ),
              )
            ],
          ),
          Container(
            width: controller.dataContainerWidth,
            decoration: BoxDecoration(
              color: controller.nameContainerColor,
            ),
            child: Text(
              title.isEmpty ? 'Iphone 16 Pro Max' : title,
              style: controller.nameTextStyle.copyWith(
                color: controller.nameFontColor,
              ),
              textAlign: controller.nameTextAlign,
            ),
          ),
        ],
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
          designController.title.text =
              designController.csvData[0]['title'] ?? '';
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
                      ValueChangeSlider(
                        value: designController.flagWidth,
                        max: 300,
                        title:
                            'Flag Width: ${designController.flagWidth.toInt()}',
                        onChanged: (value) {
                          designController.flagWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.flagPosition,
                        max: 600,
                        title:
                            'Flag Position: ${designController.flagPosition.toInt()}',
                        onChanged: (value) {
                          designController.flagPosition = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picContainerSize,
                        max: 600,
                        title:
                            'Icon Width: ${designController.picContainerSize.toInt()}',
                        onChanged: (value) {
                          designController.picContainerSize = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.IconsSpacing,
                        max: 200,
                        title:
                            'Icon Spacing: ${designController.IconsSpacing.toInt()}',
                        onChanged: (value) {
                          designController.IconsSpacing = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.IconPosition,
                        max: 800,
                        title:
                            'Icon Position: ${designController.IconPosition.toInt()}',
                        onChanged: (value) {
                          designController.IconPosition = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picContainerRadius,
                        max: 100,
                        title:
                            'Icon Radius: ${designController.picContainerRadius.toInt()}',
                        onChanged: (value) {
                          designController.picContainerRadius = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      gap(h: 20),
                      ValueChangeSlider(
                        value: designController.topSpacing,
                        max: 200,
                        title:
                            'Top Spacing: ${designController.topSpacing.toInt()}',
                        onChanged: (value) {
                          designController.topSpacing = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      Text('Title Section '),
                      gap(h: 10),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          fonts: fontFamilies,
                          textStyle: designController.titleTextStyle,
                          textAlign: designController.titleTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.titleTextAlign = align;
                            });
                            designController.valueFontColor =
                                designController.titleTextStyle.color!;
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.titleTextStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
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
                      gap(h: 20),
                      Text('Sub Title Section '),
                      gap(h: 10),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          fonts: fontFamilies,
                          textStyle: designController.subTitleTextStyle,
                          textAlign: designController.subTitleTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.subTitleTextAlign = align;
                            });
                            designController.valueFontColor =
                                designController.subTitleTextStyle.color!;
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.subTitleTextStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontSizer(
                        hintText: 'Sub Title Font Size',
                        fontSize: designController.subtitleFontSize.toInt(),
                        increase: () {
                          designController.subtitleFontSize++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.subtitleFontSize--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Sub Title Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.subtitleFontColor,
                            onChange: (color) {
                              designController.subtitleFontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.subtitleFontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Name Container Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.nameContainerColor,
                            onChange: (color) {
                              designController.nameContainerColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.nameContainerColor,
                      ),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          fonts: fontFamilies,
                          textStyle: designController.nameTextStyle,
                          textAlign: designController.nameTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.nameTextAlign = align;
                            });
                            designController.valueFontColor =
                                designController.nameTextStyle.color!;
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.nameTextStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
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
                    ],
                  ),
                  gap(w: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FontSizer(
                        hintText: 'Data Container Width',
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
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          fonts: fontFamilies,
                          textStyle: designController.valueTextStyle,
                          textAlign: designController.valueTextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.valueTextAlign = align;
                            });
                            designController.valueFontColor =
                                designController.valueTextStyle.color!;
                            setState(() {});
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.valueTextStyle = style;
                            });
                            setState(() {});
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
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
                        hintText: 'Value Container Shadow1',
                        pickerTap: () {
                          colorPicker(
                            currentColor:
                                designController.valueContainerShadow1,
                            onChange: (color) {
                              designController.valueContainerShadow1 = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueContainerShadow1,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Container Shadow2',
                        pickerTap: () {
                          colorPicker(
                            currentColor:
                                designController.valueContainerShadow2,
                            onChange: (color) {
                              designController.valueContainerShadow2 = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueContainerShadow2,
                      ),
                      FontSizer(
                        hintText: 'Shadow Radius',
                        fontSize:
                            designController.valueContainerShadowRadius.toInt(),
                        increase: () {
                          designController.valueContainerShadowRadius++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerShadowRadius--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Value Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueFontColor,
                            onChange: (color) {
                              designController.valueFontColor = color;
                              designController.valueTextStyle.apply(
                                  color: designController.valueFontColor);
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueFontColor,
                      ),
                      FontSizer(
                        hintText: 'Country Name Font Size',
                        fontSize: designController.countryFlagSize.toInt(),
                        increase: () {
                          designController.countryFlagSize++;
                          designController.update();
                          setState(() {});
                        },
                        decrease: () {
                          designController.countryFlagSize--;
                          designController.update();

                          setState(() {});
                        },
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
                      ColorPickerItem(
                        hintText: 'Shadow Color',
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
                tableItems('title'),
                tableItems('subtitle'),
                tableItems('value1'),
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
