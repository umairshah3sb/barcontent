import 'dart:async';

import 'package:barcontent/screen/design/design9/controller/design9_controller.dart';
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
import 'package:typewritertext/typewritertext.dart';

class Design9 extends StatefulWidget {
  const Design9({super.key});

  @override
  State<Design9> createState() => _Design9State();
}

class _Design9State extends State<Design9> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();
  final Design9Controller designController = Get.put(Design9Controller());
  TextEditingController videoTimer = TextEditingController();
  TypeWriterController? tcontroller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      key: _Key,
      body: GetBuilder<Design9Controller>(builder: (controller) {
        return Stack(
          children: [
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height,
                        width: controller
                            .dataContainerWidth, // You can change this value
                        decoration: BoxDecoration(
                          gradient: controller.backgroundGradient,
                        ),
                        child: controller.backgroundImage.text.isNotEmpty
                            ? Opacity(
                                opacity:
                                    (controller.backgroundImageOpacity / 10),
                                child: Image.network(
                                  controller.backgroundImage.text,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : gap(),
                      ),
                      Positioned(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: controller.backgroundGradient,
                            ),
                            height: Get.height,
                            width: controller.dataContainerWidth,
                          ),
                        ),
                      ),
                    ],
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
                  aspectRatio: 9 / 16,
                  child: Container(
                    width: controller
                        .dataContainerWidth, // You can change this value
                    height: Get.height,
                    margin: spacing(
                      v: controller.dataContainerMarginV,
                      h: controller.dataContainerMarginH,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: controller.logoContainerHeight,
                                width: controller.dataContainerWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlagSection(
                                      designController.logo1.text,
                                      designController.name1.text,
                                      isFirst: true,
                                    ),
                                    FlagSection(
                                      designController.logo2.text,
                                      designController.name2.text,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 15,
                                child: Center(
                                  child: Container(
                                    width: controller.titleContainerWidth,
                                    alignment: Alignment.center,
                                    child: Text(
                                      controller.title.text,
                                      style: controller.titleTextStyle.copyWith(
                                        color: controller.titleFontColor,
                                        shadows: [
                                          Shadow(
                                            color: controller.titleShadowColor,
                                            offset: Offset.zero,
                                            blurRadius: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: spaceOnly(bottom: 70),
                              controller: controller.scrollController,
                              child: Column(
                                children: controller.itemsList,
                              ),
                            ),
                          ),
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
          ],
        );
      }),
    );
  }

  Widget FlagSection(String president, String flag, {bool isFirst = false}) {
    return Stack(
      children: [
        SizedBox(
          width: designController.logoSize,
          height: designController.logoSize,
          child: ClipRRect(
            borderRadius: borderRadius(designController.logoRadius),
            child: CachedNetworkImage(
              imageUrl: president.isNotEmpty
                  ? president
                  : 'https://t4.ftcdn.net/jpg/02/44/43/69/360_F_244436923_vkMe10KKKiw5bjhZeRDT05moxWcPpdmb.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        isFirst
            ? Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  width: designController.flagWidth,
                  child: ClipRRect(
                    borderRadius: borderRadius(designController.logoRadius),
                    child: CachedNetworkImage(
                      imageUrl: flag.isNotEmpty
                          ? flag
                          : 'https://cdn.pixabay.com/animation/2022/08/07/20/19/20-19-52-205_512.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: designController.flagWidth,
                  child: ClipRRect(
                    borderRadius: borderRadius(designController.logoRadius),
                    child: CachedNetworkImage(
                      imageUrl: flag.isNotEmpty
                          ? flag
                          : 'https://cdn.pixabay.com/animation/2022/08/07/20/19/20-19-52-205_512.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
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
      fileBytes.toString();
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
                    gap(w: 15),
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
                        Text('Title Bottom'),
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
                            controller: designController.title2,
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
                  ],
                ),
                gap(h: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Flag 1'),
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
                        Text('PM 1'),
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
                        Text('Flag 2'),
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
                              hintText: 'Enter Flag2',
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
                        Text('PM 2'),
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
                              hintText: 'Enter PM2 Image Url',
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
                        hintText: 'Logo Container Height',
                        fontSize: designController.logoContainerHeight.toInt(),
                        increase: () {
                          designController.logoContainerHeight++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.logoContainerHeight--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Flag width',
                        fontSize: designController.flagWidth.toInt(),
                        increase: () {
                          designController.flagWidth++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.flagWidth--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Value Width',
                        fontSize: designController.valueWidth.toInt(),
                        increase: () {
                          designController.valueWidth++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.valueWidth--;
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
                        hintText: 'Data Container vertical',
                        fontSize: designController.dataContainerMarginV.toInt(),
                        increase: () {
                          designController.dataContainerMarginV++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.dataContainerMarginV--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Data Container Horizontal',
                        fontSize: designController.dataContainerMarginH.toInt(),
                        increase: () {
                          designController.dataContainerMarginH++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.dataContainerMarginH--;
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
                      ColorPickerItem(
                        hintText: 'Pic Icons Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor:
                                designController.picIconColor ?? Colors.black,
                            onChange: (color) {
                              designController.picIconColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor:
                            designController.picIconColor ?? Colors.black,
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
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.valueTextStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
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
                            currentColor:
                                designController.valueContainerLeft == null
                                    ? Colors.white
                                    : designController.valueContainerLeft!,
                            onChange: (color) {
                              designController.valueContainerLeft = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor:
                            designController.valueContainerLeft == null
                                ? Colors.white
                                : designController.valueContainerLeft!,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Container Right Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor:
                                designController.valueContainerRight == null
                                    ? Colors.white
                                    : designController.valueContainerRight!,
                            onChange: (color) {
                              designController.valueContainerRight = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor:
                            designController.valueContainerRight == null
                                ? Colors.white
                                : designController.valueContainerRight!,
                      ),
                      FontSizer(
                        hintText: 'Value Container Radius',
                        fontSize: designController.valueContainerRadius.toInt(),
                        increase: () {
                          designController.valueContainerRadius++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerRadius--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Value Container Spacing Horizontal',
                        fontSize:
                            designController.valueContainerSpacing.toInt(),
                        increase: () {
                          designController.valueContainerSpacing++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.valueContainerSpacing--;
                          designController.update();

                          setState(() {});
                        },
                      ),
                      ColorPickerItem(
                        hintText: 'Value Text Color1',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueFontColor1,
                            onChange: (color) {
                              designController.valueFontColor1 = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueFontColor1,
                      ),
                      ColorPickerItem(
                        hintText: 'Value Text Color2',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.valueFontColor2,
                            onChange: (color) {
                              designController.valueFontColor2 = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.valueFontColor2,
                      ),
                      ColorPickerItem(
                        hintText: 'Title Background Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.titleBackgroundColor,
                            onChange: (color) {
                              designController.titleBackgroundColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.titleBackgroundColor,
                      ),
                      FontSizer(
                        hintText: 'Title Container Width',
                        fontSize: designController.titleContainerWidth.toInt(),
                        increase: () {
                          designController.titleContainerWidth++;
                          designController.update();

                          setState(() {});
                        },
                        decrease: () {
                          designController.titleContainerWidth--;
                          designController.update();

                          setState(() {});
                        },
                      ),
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
                      ColorPickerItem(
                        hintText: 'Title Shadow Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.titleShadowColor,
                            onChange: (color) {
                              designController.titleShadowColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.titleShadowColor,
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
                            designController.backgroundImageOpacity++;
                            designController.update();
                            setState(() {});
                          }
                        },
                        decrease: () {
                          if (designController.backgroundImageOpacity >= 0) {
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
