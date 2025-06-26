import 'dart:async';

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/exporter.dart';
import 'package:barcontent/util/helper.dart';

class design1Controller extends GetxController {
  List<dynamic> csvData = [dumyData, dumyData, dumyData];
  bool isGenerating = false;
  bool enableScroll = false;
  double nameFontSize = 45;
  int itemsPerScreen = 4;
  double largTextSize = 90;
  double smallTextSize = 30;
  double roleTextSize = 30;
  double roleContainerHeight = 100;
  double nameContainerHeight = 100;
  double iconSize = 90;
  int videoDuration = 90;
  Color nameContainerColor = whiteColor;
  Color indexContainerColor = HexColor('#ffbd59');
  Color roleContainerColor = HexColor('#ffbd59');
  Color indexFontColor = halfBlack;
  Color roleFontColor = halfBlack;
  Color nameFontColor = halfBlack;
  Color LargeTextContainer = HexColor('#919191');
  Color largeFontColor = HexColor('#ffbd59');
  Color smallFontColor = whiteColor;

  updateFlow() {
    update();
    Timer(Duration(seconds: (videoDuration + 30)), () {
      isGenerating = false;
      enableScroll = false;
      update();
    });
  }
}
