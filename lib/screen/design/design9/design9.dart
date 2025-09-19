import 'dart:async';

import 'package:barcontent/screen/design/design9/controller/design9_controller.dart';
import 'package:barcontent/screen/design/design9/text_type_writer.dart';
import 'package:barcontent/util/app_routes.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/font_family_selector.dart';
import 'package:barcontent/util/helper.dart';
import 'package:barcontent/util/meta_data_helper.dart';
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
    MetaHelper.setMetaData(
      title:
          "Country Power Comparison Video Maker | Free Economy, Military & Global Rankings",
      description:
          "Create free country comparison videos with no watermark. Compare nations by military power, economy, GDP, population, technology, and global influence. Generate Top 10 lists or head-to-head sliding videos easily from CSV data—ideal for YouTube, education, and research content.",
      keywords:
          "country power comparison video maker, free global ranking video generator, military vs economy video creator, country head to head comparison video, strongest countries ranking video tool, gdp and population comparison video maker, free video generator no watermark, global influence ranking video, economy vs military strength video creator, country comparison video online",
      author: "Umair Shah",
      ogImage: '${domainUrl}assets/assets/img/Design9.png',
      ogUrl: '${domainUrl}${AppRoutes.design9VideoGenerator}',
    );
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
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: controller.containerBorder,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: controller.aspectRatio,
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
            ),
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              child: Center(
                child: AspectRatio(
                  aspectRatio: controller.aspectRatio,
                  child: Stack(
                    children: [
                      Container(
                        width: controller
                            .dataContainerWidth, // You can change this value
                        height: Get.height,

                        margin: spaceOnly(
                          top: controller.dataContainerMarginTop,
                          bottom: controller.dataContainerMarginBottom,
                          left: controller.dataContainerMarginH,
                          right: controller.dataContainerMarginH,
                        ),
                        child: Center(
                          child: controller.template == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height:
                                              controller.logoContainerHeight,
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
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        padding: spaceOnly(
                                            bottom: controller.secrollPadding),
                                        controller: controller.scrollController,
                                        child: Column(
                                          children: controller.itemsList,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : controller.template == 1
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height:
                                              controller.logoContainerHeight,
                                          width: controller.dataContainerWidth,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              gap(
                                                w: controller.picContainerWidth,
                                              ),
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
                                        Expanded(
                                          child: SingleChildScrollView(
                                            padding: spaceOnly(
                                                bottom:
                                                    controller.secrollPadding),
                                            controller:
                                                controller.scrollController,
                                            child: Column(
                                              children: controller.itemsList,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              gap(
                                                w: controller.picContainerWidth,
                                              ),
                                              Flag(
                                                designController.name1.text,
                                              ),
                                              Flag(
                                                designController.name2.text,
                                              ),
                                            ],
                                          ),
                                        ),
                                        gap(
                                            h: designController
                                                .flagBottomSpacing),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            padding: spaceOnly(
                                                bottom:
                                                    controller.secrollPadding),
                                            controller:
                                                controller.scrollController,
                                            child: Column(
                                              children: controller.itemsList,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: controller.UserPicHeght,
                                          width: controller.dataContainerWidth,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              gap(
                                                w: controller.picContainerWidth,
                                              ),
                                              designController.logo1.text
                                                      .toString()
                                                      .isEmpty
                                                  ? gap()
                                                  : SizedBox(
                                                      width: designController
                                                          .UserPicWidth,
                                                      height: designController
                                                          .UserPicHeght,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            borderRadius(
                                                                designController
                                                                    .logoRadius),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              designController
                                                                  .logo1.text,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                              designController.logo2.text
                                                      .toString()
                                                      .isEmpty
                                                  ? gap()
                                                  : SizedBox(
                                                      width: designController
                                                          .UserPicWidth,
                                                      height: designController
                                                          .UserPicHeght,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            borderRadius(
                                                                designController
                                                                    .logoRadius),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              designController
                                                                  .logo2.text,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                      Positioned(
                        left: designController.titlePositionLeft,
                        top: designController.titlePositionTop,
                        child: Center(
                          child: Container(
                            width: controller.titleContainerWidth,
                            alignment: Alignment.centerLeft,
                            child: designController.typeTitle
                                ? TextTypeWriter(
                                    key: Key(getRandomString(20)),
                                    text: controller.title.text,
                                    style: GoogleFonts.getFont(
                                      controller.titleFontFamily,
                                      color: controller.titleFontColor,
                                      fontSize:
                                          controller.titleTextStyle.fontSize,
                                      fontWeight:
                                          controller.titleTextStyle.fontWeight,
                                      wordSpacing:
                                          controller.titleTextStyle.wordSpacing,
                                      decoration:
                                          controller.titleTextStyle.decoration,
                                      letterSpacing: controller
                                          .titleTextStyle.letterSpacing,
                                      height: controller.titleTextStyle.height,
                                      backgroundColor: controller
                                          .titleTextStyle.backgroundColor,
                                      shadows: [
                                        Shadow(
                                          color: controller.titleShadowColor,
                                          offset: Offset.zero,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    textAlign: controller.titleTextAlign,
                                    typingSpeed: controller.typingSpeed,
                                  )
                                : Text(
                                    controller.title.text,
                                    style: GoogleFonts.getFont(
                                      controller.titleFontFamily,
                                      color: controller.titleFontColor,
                                      fontSize:
                                          controller.titleTextStyle.fontSize,
                                      fontWeight:
                                          controller.titleTextStyle.fontWeight,
                                      wordSpacing:
                                          controller.titleTextStyle.wordSpacing,
                                      decoration:
                                          controller.titleTextStyle.decoration,
                                      letterSpacing: controller
                                          .titleTextStyle.letterSpacing,
                                      height: controller.titleTextStyle.height,
                                      backgroundColor: controller
                                          .titleTextStyle.backgroundColor,
                                      shadows: [
                                        Shadow(
                                          color: controller.titleShadowColor,
                                          offset: Offset.zero,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    textAlign: controller.titleTextAlign,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: designController.title2PositionLeft,
                        top: designController.title2PositionTop,
                        child: designController.showTitle2
                            ? Center(
                                child: Container(
                                  width: controller.title2ContainerWidth,
                                  alignment: Alignment.centerLeft,
                                  child: TextTypeWriter(
                                    key: Key(getRandomString(20)),
                                    text: controller.title2.text,
                                    style: GoogleFonts.getFont(
                                      controller.title2FontFamily,
                                      color: controller.title2FontColor,
                                      fontSize:
                                          controller.title2TextStyle.fontSize,
                                      fontWeight:
                                          controller.title2TextStyle.fontWeight,
                                      wordSpacing: controller
                                          .title2TextStyle.wordSpacing,
                                      decoration:
                                          controller.title2TextStyle.decoration,
                                      letterSpacing: controller
                                          .title2TextStyle.letterSpacing,
                                      height: controller.title2TextStyle.height,
                                      backgroundColor: controller
                                          .title2TextStyle.backgroundColor,
                                      shadows: [
                                        Shadow(
                                          color: controller.title2ShadowColor,
                                          offset: Offset.zero,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    textAlign: controller.title2TextAlign,
                                    typingSpeed: controller.typingSpeed,
                                  ),
                                ),
                              )
                            : gap(),
                      ),
                    ],
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
          width: designController.UserPicWidth,
          height: designController.UserPicHeght,
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

  Widget Flag(String flag) {
    return Container(
      width: designController.flagWidth,
      margin: spaceOnly(right: designController.flagRightSpacing),
      child: ClipRRect(
        borderRadius: borderRadius(designController.logoRadius),
        child: CachedNetworkImage(
          imageUrl: flag.isNotEmpty
              ? flag
              : 'https://cdn.pixabay.com/animation/2022/08/07/20/19/20-19-52-205_512.gif',
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
                      ValueChangeSlider(
                        value: designController.UserPicWidth,
                        max: 250,
                        title:
                            'User Pic Width: ${designController.UserPicWidth.toInt()}',
                        onChanged: (value) {
                          designController.UserPicWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.UserPicHeght,
                        max: 250,
                        title:
                            'User Pic Height: ${designController.UserPicHeght.toInt()}',
                        onChanged: (value) {
                          designController.UserPicHeght = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.flagWidth,
                        max: 200,
                        title:
                            'Flag width: ${designController.flagWidth.toInt()}',
                        onChanged: (value) {
                          designController.flagWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.flagBottomSpacing,
                        max: 200,
                        title:
                            'Flag bottom spacing: ${designController.flagBottomSpacing.toInt()}',
                        onChanged: (value) {
                          designController.flagBottomSpacing = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      designController.template == 2
                          ? ValueChangeSlider(
                              value: designController.flagRightSpacing,
                              max: 200,
                              title:
                                  'Flag Spacing Right: ${designController.flagRightSpacing.toInt()}',
                              onChanged: (value) {
                                designController.flagRightSpacing = value;
                                designController.update();
                                setState(() {});
                              },
                            )
                          : gap(),
                      ValueChangeSlider(
                        value: designController.dataContainerHeight,
                        max: 250,
                        title:
                            'Data Container Height: ${designController.dataContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.dataContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.dataContainerWidth,
                        max: 2300,
                        title:
                            'Main Container Width: ${designController.dataContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.dataContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.dataContainerMarginTop,
                        max: 250,
                        title:
                            'Data Container Spacing Top: ${designController.dataContainerMarginTop.toInt()}',
                        onChanged: (value) {
                          designController.dataContainerMarginTop = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.dataContainerMarginBottom,
                        max: 250,
                        title:
                            'Data Container Spacing Bottom: ${designController.dataContainerMarginBottom.toInt()}',
                        onChanged: (value) {
                          designController.dataContainerMarginBottom = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.dataContainerMarginH,
                        max: 100,
                        title:
                            'Data Container Horizontal: ${designController.dataContainerMarginH.toInt()}',
                        onChanged: (value) {
                          designController.dataContainerMarginH = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.valueWidth,
                        title:
                            'Value Width: ${designController.valueWidth.toInt()}',
                        onChanged: (value) {
                          designController.valueWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.valueContainerSize,
                        max: 250,
                        title:
                            'Value Container Size: ${designController.valueContainerSize.toInt()}',
                        onChanged: (value) {
                          designController.valueContainerSize = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      FontSizer(
                        hintText: 'Value Container Spacing',
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
                      ValueChangeSlider(
                        value: designController.picContainerHeight,
                        max: 500,
                        title:
                            'Pic Contaner Height: ${designController.picContainerHeight.toInt()}',
                        onChanged: (value) {
                          designController.picContainerHeight = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picContainerWidth,
                        max: 500,
                        title:
                            'Pic Contaner Width: ${designController.picContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.picContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.picContainerRadius,
                        max: 250,
                        title:
                            'Pic Container Radius: ${designController.picContainerRadius.toInt()}',
                        onChanged: (value) {
                          designController.picContainerRadius = value;
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
                      Container(
                        width: 300,
                        child: Row(
                          children: [
                            Text(
                              'Enable Scroll',
                            ),
                            Spacer(),
                            Switch(
                              value: designController.enableScroll,
                              onChanged: (value) {
                                designController.enableScroll = value;
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      ValueChangeSlider(
                        value: designController.secrollPadding,
                        max: 150,
                        title:
                            'Scroll Padding: ${designController.secrollPadding.toInt()}',
                        onChanged: (value) {
                          designController.secrollPadding = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      Row(
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
                              designController.flagWidth = 90;
                              designController.dataContainerSpacing = 1;
                              designController.picContainerWidth = 80;
                              designController.UserPicHeght = 98;
                              designController.UserPicWidth = 98;
                              designController.valueTextStyle
                                  .copyWith(fontSize: 27);
                              designController.dataContainerMarginTop = 100;
                              designController.dataContainerMarginBottom = 70;
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
                      ColorPickerItem(
                        hintText: 'Border Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.containerBorder,
                            onChange: (color) {
                              designController.containerBorder = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.containerBorder,
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
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
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
                      FontFamilyDropdown(
                        text: 'Value Font Family',
                        onFontSelected: (font) {
                          designController.valueFontFamily = font;
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
                      ValueChangeSlider(
                        value: designController.titleContainerWidth,
                        title:
                            'Title Container Width: ${designController.titleContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.titleContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.titlePositionTop,
                        max: 150,
                        title:
                            'Title Position Top: ${designController.titlePositionTop.toInt()}',
                        onChanged: (value) {
                          designController.titlePositionTop = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.titlePositionLeft,
                        max: 150,
                        title:
                            'Title Position Left: ${designController.titlePositionLeft.toInt()}',
                        onChanged: (value) {
                          designController.titlePositionLeft = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
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
                      gap(h: 10),
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
                          ),
                        ),
                        child: TextFormField(
                          controller: designController.typingSpeedController,
                          decoration: InputDecoration(
                            hintText: 'Typing duration',
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: halfBlack,
                            ),
                          ),
                          onChanged: (value) {
                            designController.typingSpeed =
                                int.parse(value.toString());
                            designController.update();
                            setState(() {});
                          },
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
                      FontFamilyDropdown(
                        text: 'Title Font Family',
                        onFontSelected: (font) {
                          designController.titleFontFamily = font;
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
                      ValueChangeSlider(
                        value: designController.title2ContainerWidth,
                        title:
                            'Title2 Container Width: ${designController.title2ContainerWidth.toInt()}',
                        onChanged: (value) {
                          designController.title2ContainerWidth = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.title2PositionTop,
                        max: 150,
                        title:
                            'Title2 Position Top: ${designController.title2PositionTop.toInt()}',
                        onChanged: (value) {
                          designController.title2PositionTop = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      ValueChangeSlider(
                        value: designController.title2PositionLeft,
                        max: 150,
                        title:
                            'Title2 Position Left: ${designController.title2PositionLeft.toInt()}',
                        onChanged: (value) {
                          designController.title2PositionLeft = value;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      Container(
                        width: 300,
                        child: TextStyleEditor(
                          paletteColors: colorList,
                          fonts: fontFamilies,
                          textStyle: designController.title2TextStyle,
                          textAlign: designController.title2TextAlign,
                          onTextAlignEdited: (align) {
                            setState(() {
                              designController.title2TextAlign = align;
                            });
                            designController.update();
                          },
                          onTextStyleEdited: (style) {
                            setState(() {
                              designController.title2TextStyle = style;
                            });
                            designController.update();
                          },
                          onCpasLockTaggle: (caps) {
                            // Uppercase or lowercase letters
                          },
                        ),
                      ),
                      FontFamilyDropdown(
                        text: 'Title2 Font Family',
                        onFontSelected: (font) {
                          designController.title2FontFamily = font;
                          designController.update();
                          setState(() {});
                        },
                      ),
                      gap(h: 10),
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
                          ),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Title2 delay',
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: halfBlack,
                            ),
                          ),
                          onChanged: (value) {
                            designController.title2Delay =
                                int.parse(value.toString());
                            designController.update();
                            setState(() {});
                          },
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
                      ColorPickerItem(
                        hintText: 'Title2 Text Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.title2FontColor,
                            onChange: (color) {
                              designController.title2FontColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.title2FontColor,
                      ),
                      ColorPickerItem(
                        hintText: 'Title2 Shadow Color',
                        pickerTap: () {
                          colorPicker(
                            currentColor: designController.title2ShadowColor,
                            onChange: (color) {
                              designController.title2ShadowColor = color;
                              designController.update();
                            },
                          );
                        },
                        currentColor: designController.title2ShadowColor,
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
                if (designController.typingSpeedController.text.isNotEmpty) {
                  designController.typingSpeed = int.parse(designController
                      .typingSpeedController.text
                      .toString()
                      .trim());
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
