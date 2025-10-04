import 'dart:async';

import 'package:barcontent/screen/design/design17/widget/design17_item1.dart';
import 'package:barcontent/screen/design/design17/widget/design17_item2.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class Design17Controller extends GetxController {
  List<dynamic> csvData = [
    dumy17Data,
    dumy17Data,
    dumy17Data,
    dumy17Data,
  ];

  double aspectRatio = 16 / 9;

  int currentIndex = 0;
  int template = 0;
  List<Widget> animatedItem = [];
  bool isGenerating = false;
  bool enableScroll = false;
  bool isAnimate = false;
  bool hideIndex = false;
  bool reverseData = false;
  bool randomData = false;
  bool enableRandomColor = true;
  bool enableTagline = true;
  double itemsWidth = 316;
  int spaceBetween = 4;
  double itemMarginH = 4;
  double itemMarginV = 4;
  double initialItems = 4;
  double itemBorderRadius = 0;

  double diamondWidth = 360;
  double diamondHeight = 250;
  double diamondContainerHeight = 250;
  double diamondRadius = 10;
  double diamondBorder = 5;
  Color diamondBorderColor = Colors.transparent;

  double smallTextSize = 30;
  double pic1Width = 360;
  double pic1Height = 250;
  double pic1ContainerHeight = 250;
  double iconSize = 190;
  double iconRadius = 0;
  double iconSpace = 20;
  double pic1Radius = 10;
  double pic1Border = 5;
  Color pic1BorderColor = Colors.transparent;
  int videoDuration = 150;
  Color nameContainerColor = whiteColor;
  Color indexContainerColor = HexColor('#ffbd59');
  Color indexFontColor = halfBlack;
  Color itemBackGroundColor = Colors.transparent;
  Color bottomContainerColor = halfBlack;
  Color backgroundColor = halfBlack;
  Color animationContainerColor = halfBlack;
  double largTextSize = 45;
  Color picBackgroundColor = Colors.yellow;
  List<BoxShadow>? iconShadow;
  List<BoxShadow>? picShadow;

//largeText
  String largeFontFamily = 'Russo One';
  double largeContainerHeight = 45;
  Color largeFontColor = Colors.yellow;
  TextAlign largeTextAlign = TextAlign.center;
  TextStyle largeStyle = GoogleFonts.manrope(
    color: Colors.yellow,
    fontSize: 45,
    fontWeight: FontWeight.w900,
  );

//smallText
  String smallFontFamily = 'Russo One';
  double smallContainerHeight = 45;
  Color smallFontColor = Colors.white;
  TextAlign smallTextAlign = TextAlign.center;
  TextStyle smallStyle = GoogleFonts.manrope(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.w900,
  );

//Name
  String nameFontFamily = 'Russo One';
  double nameContainerHeight = 45;
  Color nameFontColor = halfBlack;
  TextAlign nameTextAlign = TextAlign.center;
  TextStyle nameStyle = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 45,
    fontWeight: FontWeight.w900,
  );

//tagline
  double taglineContainerHeight = 90;
  String taglineFontFamily = 'Russo One';
  Color taglineFontColor = Colors.yellow;
  Color taglineTextContainer = Colors.black;
  TextAlign tagTextAlign = TextAlign.center;
  TextStyle taglineStyle = GoogleFonts.manrope(
    color: Colors.black,
    fontSize: 45,
    fontWeight: FontWeight.w900,
  );

  @override
  void onInit() {
    update();
    super.onInit();
  }

  updateFlow() async {
    await Future.delayed(Duration(seconds: 5));
    animatedItem = [];
    isAnimate = true;
    isGenerating = true;
    update();
    for (var i = 0; i < initialItems; i++) {
      currentIndex = i;
      if (template == 0) {
        animatedItem.add(Design17Item1(
          index: i,
          data: csvData[i],
        ));
      } else if (template == 1) {
        animatedItem.add(Design17Item2(
          index: i,
          data: csvData[i],
        ));
      }
      await Future.delayed(
        Duration(seconds: 4),
      );
      update();
    }
    isAnimate = false;
    update();

    Timer(Duration(seconds: (videoDuration + 15)), () {
      isGenerating = false;
      enableScroll = false;
      update();
    });
  }
}
