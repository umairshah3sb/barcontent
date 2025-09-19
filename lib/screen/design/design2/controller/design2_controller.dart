import 'dart:async';

import 'package:barcontent/screen/design/design2/widget/design2_item.dart';
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class design2Controller extends GetxController {
  List<dynamic> csvData = [design2Data, design2Data, design2Data];
  int currentIndex = 0;
  List<Widget> animatedItem = [];
  bool isGenerating = false;
  bool enableScroll = false;
  bool isAnimate = false;
  bool hideIndex = false;
  bool enableRandomColor = true;
  double nameFontSize = 45;
  double nameContainerHeight = 45;
  int itemsPerScreen = 4;
  int spaceBetween = 4;
  double itemMarginH = 4;
  double itemMarginV = 4;
  double initialItems = 4;
  double itemBorderRadius = 0;
  double largTextSize = 45;
  double largContainerHeight = 90;
  double smallTextSize = 30;
  double pic1Width = 360;
  double pic1Height = 250;
  double pic1ContainerHeight = 250;
  double pic2Width = 330;
  double pic2Height = 250;

  double pic2Radius = 10;
  double pic2Border = 5;
  Color pic2BorderColor = Colors.transparent;

  double pic1Radius = 10;
  double pic1Border = 5;
  Color pic1BorderColor = Colors.transparent;

  int videoDuration = 150;
  Color nameContainerColor = whiteColor;
  Color indexContainerColor = HexColor('#ffbd59');
  Color indexFontColor = halfBlack;
  Color nameFontColor = halfBlack;
  Color itemBackGroundColor = Colors.transparent;
  Color pic2ContainerColor = halfBlack;
  Color LargeTextContainer = Colors.black;
  Color animationContainerColor = halfBlack;

  Color largeFontColor = Colors.yellow;
  Color picBackgroundColor = Colors.yellow;
  Color smallFontColor = whiteColor;

  updateFlow() async {
    animatedItem = [];
    isAnimate = true;
    isGenerating = true;
    update();
    for (var i = 0; i < initialItems; i++) {
      currentIndex = i;
      animatedItem.add(Design2Item(
        index: i,
        data: csvData[i],
      ));
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
